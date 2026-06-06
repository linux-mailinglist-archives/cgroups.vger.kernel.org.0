Return-Path: <cgroups+bounces-16684-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wrl9FfNLJGow5AEAu9opvQ
	(envelope-from <cgroups+bounces-16684-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 18:33:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890E64DED1
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 18:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=HbGzotYl;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16684-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16684-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AC0A3026AA7
	for <lists+cgroups@lfdr.de>; Sat,  6 Jun 2026 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E082E7370;
	Sat,  6 Jun 2026 16:32:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AC2E7388;
	Sat,  6 Jun 2026 16:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780763523; cv=none; b=YE6krGhOceU6oTnULDb19y+huGcm0O4pkXMUueDkgFse9oCerwI7V7isjcX+T7cDHo9URop9he6KdBHHDpQwf+FH7LDJf2d87mGZHPPP6m70I3R68znYgCby+S4YDLP0EjpTJ0iyP3og8K0tv4pRtlOKalZ3ePSWxMsoFLLM6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780763523; c=relaxed/simple;
	bh=vUONu7L3LZvbNsjDm4QdbY0CkriiSOy3SytSf4P+02w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngaArWUfZ/z2tdJVZbKA2zkjpOGGq0sC4sy9oHU8MhHgjWZMKKP5MDZv4nzBDTp5emEMdtwH8Tg2Y9tM9z0xrWOUUmAjoKzpO6za3CkPyk6JfRWl9r20gpfFB65APJoy8657oye02AZl0tfThUGAScMqyCdwgw9umtyerRX/vN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=HbGzotYl; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780763514; x=1781368314; i=natalie.vock@gmx.de;
	bh=pu9Y/1db4ddY2fvcdaqOKNsuLfkux6ZxDG6udwBi+FM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HbGzotYlLBYXJg96I1QOtQm+EUjOGFW6274hBeNJ3RTJNvcqUiQx/L9jEyn9RY8s
	 K4YnKJdvTDTUABlW/c0ZzHTHgor/MWV8zNbSRXSHCcM5lDYXWuLltQB4BCT5fb94h
	 3AVq7eh3hWKcwtOyKHN/GG5TM60psRJH46QdutGnypulHtpjTiUVmqfhfA4ysYMUU
	 ZF6HJX2w/PBPAc1bcRmAzcbQpnedCS9A4Q40GFJSX3cIAcQQHHHinn6Kv9aHAx3mN
	 761yU2WBp+W/84V0uigr/1ete4xUzmMgiytOjbGsy7d6Y85zlNOsNZiQYvmplt9D6
	 ZPd7JMxzwsDfnFbUow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1wOVPD0X2j-00EE81; Sat, 06
 Jun 2026 18:31:54 +0200
Message-ID: <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
Date: Sat, 6 Jun 2026 18:31:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
To: Eric Chanudet <echanude@redhat.com>, Maarten Lankhorst
 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GeqB1KHB8+oY7GplIx7scS9gLJSL2XEOIdPhnns0GNIwOG/AEIy
 PVnpXcSeDwVcbn9jQyRLZF+2RtNWRcXythUjn9uN3v38LSYpUfyWOtnn2LTFDesui34Ix9D
 aKaBzyVEKx9R7HCuca3MyGrynWCE3FK1rhs9z7lAts62u8Mort8aHjstsZ2hUxgJIsvzDRy
 1VyA6aqLwlO+G448Pk+IA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rkntulTOD78=;TVYaZu3xxAL0okeGjJBFk77PPzM
 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
 n+9FHen/HKY6ocUeb0VC9+n1J2yb0PW88gBCbnN
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16684-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:echanude@redhat.com,m:dev@lankhorst.se,m:mripard@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:from_mime,gmx.de:dkim,patchwork.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9890E64DED1

On 6/6/26 00:44, Eric Chanudet wrote:
> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> dmem.low files.>
> This changes the UAPI that otherwise accepted multiple lines for setting
> multiple entries in one write. No existing user is known to rely on
> writing multiple regions in a single write.

Ugh, shoot.

For dmem.low specifically, there already are some userspace thingies=20
floating around that may write more than one region/value pairs.

These thingies all depend on that one patchset for dmemcg protection=20
that I should really get around to merging[1]. Since the userspace=20
utilities depend on not-yet-merged patches, they sort of have to expect=20
stuff changing under their belts, so I wouldn't really consider those=20
users a blocker by necessity.

As I see it, we could go down one of two paths:
1. We go ahead with the patch as proposed, and I make sure that the=20
users I know of adapt. Could be a bit icky wrt. "do not break userspace"=
=20
rules, but since the already use non-merged UAPIs in one place, you can=20
argue that these users kind of have to expect breakage.
2. We use the old handling allowing multiple lines for dmem.min and=20
dmem.low only. This preserves compatibility but uglifies the code by=20
quite a bit.

All things considered, I think I personally would prefer going with 1.=20
and taking the patch as proposed and just having one codepath handling=20
every limit file. Just highlighting this so we don't do it on accident.

[1] https://patchwork.freedesktop.org/series/163183/

Some more review comments inline.

>=20
> Processing multiple regions in dmemcg_limit_write() could quietly change
> first limits before failing on a later one and returning an error to the
> writer, with no indication some changes occurred.
>=20
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
> Follow up from discussions on a previous thread[1].
> If Albert's series[2] lands, I can cleanup and prepare some kunits for
> these as well.
> [1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lan=
khorst.se/
> [2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4=
@redhat.com/
> ---
>   kernel/cgroup/dmem.c | 70 +++++++++++++++++++-------------------------=
=2D-------
>   1 file changed, 26 insertions(+), 44 deletions(-)
>=20
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def54=
6adf5cc175d7f0be 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_op=
en_file *of,
>   				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
>   {
>   	struct dmemcg_state *dmemcs =3D css_to_dmemcs(of_css(of));
> -	int err =3D 0;
> -
> -	while (buf && !err) {
> -		struct dmem_cgroup_pool_state *pool =3D NULL;
> -		char *options, *region_name;
> -		struct dmem_cgroup_region *region;
> -		u64 new_limit;
> -
> -		options =3D buf;
> -		buf =3D strchr(buf, '\n');
> -		if (buf)
> -			*buf++ =3D '\0';
> -
> -		options =3D strstrip(options);
> -
> -		/* eat empty lines */
> -		if (!options[0])
> -			continue;
> -
> -		region_name =3D strsep(&options, " \t");
> -		if (!region_name[0])
> -			continue;
> -
> -		if (!options || !*options)
> -			return -EINVAL;
> +	struct dmem_cgroup_pool_state *pool;
> +	struct dmem_cgroup_region *region;
> +	char *region_name;
> +	u64 new_limit;
> +	int err;
>  =20
> -		rcu_read_lock();
> -		region =3D dmemcg_get_region_by_name(region_name);
> -		rcu_read_unlock();
> +	buf =3D strstrip(buf);
> +	region_name =3D strsep(&buf, " \t");
> +	if (!region_name[0] || !buf)

If buf is NULL, isn't strsep(&buf, ...) also NULL? region_name[0] would=20
therefore be a NULL pointer deref. Flipping the order of the logical or=20
should be enough to prevent this.

> +		return -EINVAL;
>  =20
> -		if (!region)
> -			return -EINVAL;
> +	rcu_read_lock();
> +	region =3D dmemcg_get_region_by_name(region_name);
> +	rcu_read_unlock();
> +	if (!region)
> +		return -EINVAL;
>  =20
> -		err =3D dmemcg_parse_limit(options, &new_limit);
> -		if (err < 0)
> -			goto out_put;
> +	buf =3D strstrip(buf);

Do we start allowing extra spaces between region and limit as well?=20
Would also be fine by me, it doesn't break anything, just highlighting=20
that it's a change in behavior. Should perhaps be documented in the=20
commit message, too.

Also, you should be able to use skip_spaces() here for an equivalent=20
result. I'm not strongly opinionated on either way, but using=20
skip_spaces() indicates more clearly that this can only remove spaces at=
=20
the start.

Best,
Natalie

> +	err =3D dmemcg_parse_limit(buf, &new_limit);
> +	if (err < 0)
> +		goto out_put;
>  =20
> -		pool =3D get_cg_pool_unlocked(dmemcs, region);
> -		if (IS_ERR(pool)) {
> -			err =3D PTR_ERR(pool);
> -			goto out_put;
> -		}
> +	pool =3D get_cg_pool_unlocked(dmemcs, region);
> +	if (IS_ERR(pool)) {
> +		err =3D PTR_ERR(pool);
> +		goto out_put;
> +	}
>  =20
> -		/* And commit */
> -		apply(pool, new_limit);
> -		dmemcg_pool_put(pool);
> +	apply(pool, new_limit);
> +	dmemcg_pool_put(pool);
>  =20
>   out_put:
> -		kref_put(&region->ref, dmemcg_free_region);
> -	}
> -
> +	kref_put(&region->ref, dmemcg_free_region);
>  =20
>   	return err ?: nbytes;
>   }
>=20
> ---
> base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
> change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
>=20
> Best regards,


