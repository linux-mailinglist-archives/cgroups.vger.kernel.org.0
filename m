Return-Path: <cgroups+bounces-5679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEE9D88BB
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8112B39120
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA21B2183;
	Mon, 25 Nov 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BnT7u1CP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77F1B0F30
	for <cgroups@vger.kernel.org>; Mon, 25 Nov 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546180; cv=none; b=rrosCCfh44d321yp0oBCiD4RESw3lONx5WmtDcxyZCkf/okmILDHXbeoXmuo2CDuZ8BSnIzbpVF+0MewHCzYZ4GvfVrn+0nbRN1F0S8vyPQHV1PTSQjywaag1dfQRAqmgb1oW5gnhOULYXmnHEiopeCOaC7cjoy8EgUlYTbHr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546180; c=relaxed/simple;
	bh=311mP1nGWg3En457iJwSRftX35ncOjZ+ik6Rzn4d5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9CmfPnXL9lRKHLaw+gGgFe7LGcwnoE7PIec2C2jDrP0UTea3WiCn4bVsafAawdcFKg4+kWgTUkBmsI7wAsctxFpoXf7KITB6tu4E9HqRJRtDcBI/LVRFWJr0fnK+Bf7zpxm1wRyAhV0vZj8nn2xVxd60bJxM79CpFD73C6sHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BnT7u1CP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a1639637so5478305e9.1
        for <cgroups@vger.kernel.org>; Mon, 25 Nov 2024 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732546177; x=1733150977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5beJnH8BrdJiwKU1iWu/1mbgg5i4JBbnKfyaarCYcU=;
        b=BnT7u1CPe5VxLLlhK3Wasv4f9wxUrqQav/h0A1v40N8hFWQ8plLWDHYUNKIpExA8oH
         KdiaBkDAxRWlBoxCVkc/QOm4WUKwFUF9FfV9bjgg4VJuL3/4IpO0mG/mvIwzGbI0kAaN
         H1mkPsfska1gXgCt1aUmjWrZRWBWEFiVY4Hphi0J3KrcIQWPa8JI4brO6yF2Lpa1TUwN
         dHb0zvuzfEmtQCb5cTlzYPVDvxf25isW8/ed1xf0CQ3JjMvBkjuL6UXmsoaFDgofKHpz
         b5m8OQTYfhcCMLrhvLPAN4xAufy0/PCFupJ67/ljIszeOaYm+w5j69SfOrAG+YAHJ6BL
         fgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546177; x=1733150977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5beJnH8BrdJiwKU1iWu/1mbgg5i4JBbnKfyaarCYcU=;
        b=uTeDaE2kVX1ayvpRyoutwtdMWE7rlJPfe2NmSuh7hsy1GgFLb4eXnhQrFoN9avDKUJ
         kQbHoBXNJdCiTdYytdzwPTk5f3A2p0FI4L1vzDy1IKPShcuNVnDF2cUE7wq1pUDpag2P
         bflGsQ28xLEr+TdvOFWxfFI6+mcHJSeGG5xNkMIHAjX1BWc6HvA30jpsiNApX1Wy/xY0
         K+aS6/MxVq8TrDgiq8OTGzt9y3dMub0N1hRL9jncNmRZN87nurTjkwC2QQcTafmL25nQ
         J6gapnFT+Gc82ENGHF7XWAt3VCH1hv6Vd4hqd5RTzMHb/fGl5DX5PaW7B24wuAtryxn7
         5NeQ==
X-Gm-Message-State: AOJu0YzHIqgq3ItEIlKjcNCAsX8wtWnayTp1eToaX1wM5V6+mRn87Els
	elQlWnpHMvHq0SFAjedvLggLK7dDIs5VH0SPzKtKZjZdCDAAAZDka+RCxhSg5JE=
X-Gm-Gg: ASbGncvLaVeQwp/LarP5g0WobGAp/lDkpAFUMHOrWoGWaVI/T8Be5OIVvdqepDcJvrw
	obEaO3vpUFzLrDyG/KEPhCCrPko6FmKo10GCe9EYo67SGRGugWhI7Oz+Vzy1dqFdamh776d4u/K
	6xF5DdgCPIGMHaEVtn0853hcQuJTkODFo05TJWMNN1AN6k195rNROcQJ/n3X5nMuYSlCJ/7W5HB
	3Eqzg9VKAfBaQCDjnsADGfkVwAy9dzrV7sP7/Ve4lPDrfLcm7Zc
X-Google-Smtp-Source: AGHT+IEkuJuYDLImW7k5whVxzolXj77uXLERajAptIYU0GOlCi3TkW270WNVVMIk0baT0qAS9QGBtg==
X-Received: by 2002:a05:6000:178e:b0:37d:4cef:538e with SMTP id ffacd0b85a97d-38260be1e4bmr8427001f8f.55.1732546177033;
        Mon, 25 Nov 2024 06:49:37 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad61b0sm10771630f8f.7.2024.11.25.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 06:49:36 -0800 (PST)
Date: Mon, 25 Nov 2024 15:49:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hillf Danton <hdanton@sina.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de, 
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <q77njpa2bvo52lvlu47fa7tlkqivqwf2mwudxycsxqhu2mf35s@ye4i3gsy4bl7>
References: <20241121175250.EJbI7VMb@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dhzny5b66lqn6fyt"
Content-Disposition: inline
In-Reply-To: <20241121175250.EJbI7VMb@linutronix.de>


--dhzny5b66lqn6fyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Nov 21, 2024 at 06:52:50PM GMT, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> - kernfs_rename_ns() is only using kernfs_rename_lock if the parents are
>   different. All users users use either RCU or kernfs_rwsem.
> - kernfs_fop_readdir() drops kernfs_root::kernfs_rwsem while holding a
>   reference to name and invoking dir_emit(). This has been changed and
>   lock is held.
> - kernfs_notify_workfn() access kernfs_node::name without any
>   protection. Added kernfs_root::kernfs_rwsem for the iteration.
> - kernfs_get_parent_dentry() acquires now kernfs_root::kernfs_rwsem
>   while accessing the parent node.
> - kernfs_node_dentry() acquires now kernfs_root::kernfs_rwsem while
>   parent is accessed and the name looked up.

Why is the kernfs_root::kernfs_rwsem newly R-taken? Shouldn't be RCU
read section sufficient for those users?

(Perhaps it's related to second observation I have -- why there is
sometimes kernfs_rcu_get_parent() whereas there are other call sites
with mere rcu_dereference(kn->parent)?)



--dhzny5b66lqn6fyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0SOfAAKCRAt3Wney77B
SdCtAQD9A+SvpBqs8YXe02+LGU+IDexUx+gDhF4rE9B9esJtLQEAv1ML9uHAk9h8
7bHwMa0e07fuq32wxuILjEGBF15wWQA=
=Rom0
-----END PGP SIGNATURE-----

--dhzny5b66lqn6fyt--

