Return-Path: <cgroups+bounces-14816-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJL7AOE5tGl3jAAAu9opvQ
	(envelope-from <cgroups+bounces-14816-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:22:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4C286EBF
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07DF9300DF7C
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09612362125;
	Fri, 13 Mar 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BFpokNVE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E23B6372
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418972; cv=none; b=chGzNjBg3UQI9+1YeLuHJVxez4N1tx0tl6ndk+dI/BPm2FPmjxGrTt5IqtmKvW5cOsPRgFfenSekltIUvZHQCMgPKpI41YbwkWVb4KGUogRO0a90fAWpKIzciLxeM9Tqf9+p3ANYzNh9O1yDX6ASDPIDKTfACaEkEch7gKG7W4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418972; c=relaxed/simple;
	bh=Z9cItxSBJfSxGDVODHG47dPXwiilVxMtV1J7ehmwGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6palRTS60ny9EMr1MHXrCUve7s32En8n0jJIu9RHFcNKSC/e1M8evUvrg7CzoZJh0/sq/7lrTINl6/JMGZYKHWJm6vjDsJScpWADv3F6RM1jibvV9unquNl0l91V5Z7PRwzXdSCLW7aPc0xVZ1xe7ZFZ8M3XxU8StlJII0xuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BFpokNVE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso2504754f8f.3
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773418966; x=1774023766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waNi9HqZMalp9X1QHhx8NLvH4Y9lunKrP9GbZn1Q6ho=;
        b=BFpokNVEQ4Wu3jUSTPiZ4M93ZsIXZmHkYK7vlxxwFEQ6u9DOmCaz1+0lUz5X99jR45
         m7tuaq8FNgK73Rkrc8ELDG7hKDQRi4/AgOIJoa/GMHFOlrszfjp2ceqsXBSRIc0aVWG4
         9ThDNMgpdx/j7SBb0VRp/a7+B5GpOYi9tDViOESS2WZ6px4zY6CFvoWAbSYHLUgIMLv0
         FgP+pvuSETPyNL1SM1Bj6iE0D5F1SA4P/EwlBrIb0/muMhcNjFftcpCwOV5YViHUkDRA
         6Rt8s1WLao13guOmSyCVFlR9RArFOFvnK78Ui+QYxwnueSMBah70wai3ZpWpH5lnnC7J
         REBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418966; x=1774023766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waNi9HqZMalp9X1QHhx8NLvH4Y9lunKrP9GbZn1Q6ho=;
        b=P3gwhFYqeFnk8/AotAPipXORNhdaxbprTCJoBf6jMiYTJHe9G+bY5kEVIccUXecyzE
         /scXzew2GpaE4jaKcALR7eAhiufGLHFAAVQ7YKzKEvkx8b8W9EiZSM9ciPOs6OaQqhn4
         3ZEiiwgj577EMT04HeTzEKsOQ6vfjng+e7yeSbLkck9JFSgCUu2KKGQ7+NT7VraHRWqD
         zMMjvTQ5909leX+qb48xjEOSIVq4Hf3CCWjzafG3px8HhDBRQiv7Jm7vBS5npQznhn1+
         YXdOHZ1MFQmyowtV/aO4ppjqSWQzDJY2mF+m1oH9rfyzAE8vWDd7YKHggrewf4EQIEhy
         i1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA40lDMIytEr6N2/Li8hyPO3+GEij+xRPu5tX6jryU44u3s9XpHl/ZsOA0Vo8JhI2+V+dhwMqU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/oyUfvhFuh/5jIcJZzwxIk+OJtepbdgN0V9pxELI8xsFrLd6d
	n8vcXHqxo522EEBnc59ItqOjqvHD3KcyDqdSSWdSl1pkyu5ZkWsTmtbnisyluL43qnA=
X-Gm-Gg: ATEYQzxroab4CCtI8DA7nwCYlYRov0hMrbnGHzmfZ2KUkwlK31p26UjZHoOOgpP79lP
	TFnhpYz0m7xIzxpwVQ7KF7O22mKRDwHwWSvAPo+jrzJB2ehGeHyxSRegWSgsBDHns6DUAKsOY5t
	8NiuJNeN5dyZGatMTkjKUkEQFw9fwO/urvox3hwRd3lkueHl0qm2syuKLp8wJM09UhIglK5N/eu
	ThTXGoQJPzTXXyKivVQVtYNI2Pb/usnJ2l2erDNUC7zSCdn/3YWys2eT8p4MYlljvsjGOyZ2n9z
	Bhic2Sq0VdIwzqxcjpVLzVp4umyEf6/70ulXQfS+SCkSxaecIAGV8Ufzy6SfDSatSZJz9+QrMLA
	KqIMnIG5xX9jf1XuKp4KBncu8HSDHpdiQiatYrEWhyQayGzuJEwpV0Cgq8LrZZjIZtt+FRyfDDY
	DFV8xAEwCMOcGrks69ehxV9wMBGQeikjE7yAG3/csmpAU=
X-Received: by 2002:a05:600c:a6a8:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-4855670c0cfmr39549385e9.29.1773418966114;
        Fri, 13 Mar 2026 09:22:46 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6700fsm22255485e9.22.2026.03.13.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:22:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:22:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <hwcqvplnn2knclpivgagctmcaiutyv2qprgoqmwp7suzj6fqb2@diq6grkwo33b>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kq7o72d73feieu7p"
Content-Disposition: inline
In-Reply-To: <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14816-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: DFF4C286EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kq7o72d73feieu7p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
MIME-Version: 1.0

Hello Qi.

On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng <qi.zheng@linux.dev> wro=
te:
> To ensure that these non-hierarchical stats work properly, we need to
> reparent these non-hierarchical stats after reparenting LRU folios. To
> this end, this commit makes the following preparations:
>=20
> 1. implement reparent_state_local() to reparent non-hierarchical stats
> 2. make css_killed_work_fn() to be called in rcu work, and implement
>    get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>    between mod_memcg_state()/mod_memcg_lruvec_state()
>    and reparent_state_local()


css_free_rwork_fn has() already RCU deferal but we discussed some
reasons why stats reparenting cannot be done from there. IIUC something
like:

| reparent_state_local() must be already at css_killed_work_fn() because
| waiting until css_free_rwork_fn() would mean the non-hierarchical
| stats of the surrogate ancestor are outdated, e.g. underflown.
| And the waiting until css_free_rwork_fn() may still be indefinite due
| to non-folio references to the offlined memcg.

Could this be captured in the commit (if it's correct)?


> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6044,8 +6044,9 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, con=
st char *name, umode_t mode)
>   */
>  static void css_killed_work_fn(struct work_struct *work)
>  {
> -	struct cgroup_subsys_state *css =3D
> -		container_of(work, struct cgroup_subsys_state, destroy_work);
> +	struct cgroup_subsys_state *css;
> +
> +	css =3D container_of(to_rcu_work(work), struct cgroup_subsys_state, des=
troy_rwork);
> =20
>  	cgroup_lock();
> =20
> @@ -6066,8 +6067,8 @@ static void css_killed_ref_fn(struct percpu_ref *re=
f)
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
> =20
>  	if (atomic_dec_and_test(&css->online_cnt)) {
> -		INIT_WORK(&css->destroy_work, css_killed_work_fn);
> -		queue_work(cgroup_offline_wq, &css->destroy_work);
> +		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
> +		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
>  	}
>  }
>

Could this be

#ifdef CONFIG_MEMCG_V1
		/* See get_non_dying_memcg_start, get_non_dying_memcg_end
		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
#else
		INIT_WORK(&css->destroy_work, css_killed_work_fn);
		queue_work(cgroup_offline_wq, &css->destroy_work);
#endif

?

IOW there's no need to make the cgroup release path even more
asynchronous without CONFIG_MEMCG_V1 (all this seems CONFIG_MEMCG_V1
specific).

(+not so beautiful css_killed_work_fn ifdefing but given there are the
variants of _start, _end)

> +#ifdef CONFIG_MEMCG_V1
> +/*
> + * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race =
with
> + * reparenting of non-hierarchical state_locals.
> + */
> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cg=
roup *memcg)

Nit: I think the idiomatic names are begin + end (in the meaning of
paired parenthesis, don't look at css_task_iter_start ;-).

--kq7o72d73feieu7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabQ5zxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AirbAEAllLIHOekP42qBXcY9SXM
HI9aZuWe5shsjcP4rBnHz2IBAMq5mCPASHGfKEP+tb8nLIzv/PeBVFYEJSxL39zr
N9oG
=/sfd
-----END PGP SIGNATURE-----

--kq7o72d73feieu7p--

