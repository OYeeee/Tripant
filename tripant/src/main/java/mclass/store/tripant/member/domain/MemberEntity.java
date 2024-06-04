package mclass.store.tripant.member.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
public class MemberEntity implements UserDetails {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String memEmail;
	private String memNick;
	private String memPassword;
	private String memRole;
	private Integer memEnabled;
	private String memType;
	private String memJoinDate;
	private String memBirth;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(memRole));
		return authorities;
	}

	@Override
	public String getPassword() {
		return this.memPassword;
	}

	@Override
	public String getUsername() {
		return this.memEmail;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.memEnabled == 1 ? true : false;
	}
}
