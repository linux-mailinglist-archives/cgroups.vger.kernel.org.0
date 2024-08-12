Return-Path: <cgroups+bounces-4207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66794F56B
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEA4B22BD7
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0781187FEE;
	Mon, 12 Aug 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KpJ9Zv09"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F54317C
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481834; cv=none; b=NTEOTkbQnZfS/iyyXyfR7KjFRZ1zO8O8TET44GkjrM/zNsLZPUvSwRazHp3Xi7F4Wn8nQiUqMhy+oS3Kn8vKA33UD84aV3XHzPxrSneJN0wPaqwoGfBD5hO8v5Dc1I+ZYvmMKhLkzrMAsmzai5d8Crj8+KPtUqTe1dBB1AqlvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481834; c=relaxed/simple;
	bh=I3PbSbhqM8tw/YEOUjLgoOFNH+BhvQvBlDcawx+EcVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks7RvfmA/bC0kJuZxGhLUkSwIaiesPjRS/WVkLSjS0muHtCRpbUZaUUvrOHCEf893RzpxRU3mOJx3ECAUrV+n387r1kW368SW+1HlM0kvLEGgFH10QKlf+Lg+PUD8Kl8LoTUq56azxl+vA2dyYAJpAztjfme3Nzr9VU/iryTsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KpJ9Zv09; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso5284919a12.1
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723481829; x=1724086629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVYLXb9RliMChYBxq0LP5GT895BADWaNcwomfRKtbpc=;
        b=KpJ9Zv09wDc2n3U+IjwqXCBJiUD036/K2oewIx3KK8fiiEgu+8kHOz7DdCcgI93dG1
         ssUwaHG6kSDrChwFtORq1cxJl0iUKvvHVhUES4Q1wjGuGGPXJGppkQuinGlmSwcKE5yG
         zPCL0qEQx4cCVX42ggAfu0aI2BDJmOBz56ouvHtafbz8WfRH5D/E1SuR0GZfnBcVWnhk
         as3kOuzukcx4DfRvAneAknw0MhAyQgcrPMdjqcZmv8KCf89y0h+qrq1kkG+w0H7uZ6J7
         vhCzhoAoN4wWUSkyshO+z+cJ/KSrugO6AWj7ZUg5TEsieZRT4M4GW1SL/uDxRLkGl6KY
         I4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481829; x=1724086629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVYLXb9RliMChYBxq0LP5GT895BADWaNcwomfRKtbpc=;
        b=WcUMY3obcyDHl+oVpLOCf4/txwJpInRFtpWU9FNbg93w7qLNQE0/a8CjnzljRLZVOW
         VtkxLUH02VqCzlK4SKjP1vqgvp/ZyFETH0LOt/xTdMUBGhoeWePssAigSyKNNjF7x8l5
         kUJ6+pgqR9K3O+gUrUq/Th7J2II+RyVfVcyflIQXWyW6nicSopodpXn+c0VghyysvZPG
         hDL72xASE+liRZd+87HdpkgCqJxlLxWA8mVXHOXyLlK41gHVUUjJeWBoLzriB4CGWjbO
         bSCLNGmoEUEaZKSfjQxJJxVY1I+PV9wbfSgqrrYfuLzQFN/v3lkNgdDVKrAoNX25Jfsq
         RFfg==
X-Forwarded-Encrypted: i=1; AJvYcCVQOAPMWwoiQ1X2Uue1Osg0CohQyLgcE2NKzM1tEcAab+l3zByTDtUHd52Tpdw945bae5uJEJ0r2DJkpEfaAkDZ3w1mrgtazA==
X-Gm-Message-State: AOJu0YwyVsuwrPoPbML+skNKHWXQJcCXQfMmdmwYvBGmMXj1clS4+wy+
	R1jTxwsuQQ/0OKw5AGjSWuBxh5+M/aIDIuTIS6YmMQBu6+CCGYZdWtYCGB7T1dM=
X-Google-Smtp-Source: AGHT+IH1wE+EieCsVj3bS5oVu25LGc5Vs2kGbUgy673UugOlOpIl0rLAjfqASSz/4VvlLf1a3EUKcQ==
X-Received: by 2002:a05:6402:2708:b0:5a0:e61c:edfd with SMTP id 4fb4d7f45d1cf-5bd44c31822mr688756a12.14.1723481829376;
        Mon, 12 Aug 2024 09:57:09 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f306fsm2249580a12.1.2024.08.12.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:57:08 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:57:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
Message-ID: <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4mii6pqtpg374fr"
Content-Disposition: inline
In-Reply-To: <20240812073746.3070616-3-chenridong@huawei.com>


--h4mii6pqtpg374fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Aug 12, 2024 at 07:37:46AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> cd /sys/fs/cgroup
> echo '+pids' > cgroup.subtree_control
> mkdir dlgt_grp_ns
> echo '+pids' > dlgt_grp_ns/cgroup.subtree_control
> mkdir dlgt_grp_ns/dlgt_grp_ns1
> echo $$ > dlgt_grp_ns/dlgt_grp_ns1/cgroup.procs
> echo 200 > dlgt_grp_ns/dlgt_grp_ns1/pids.max
> unshare -Cm /bin/bash
> echo max > /dlgt_grp_ns1/pids.max // Permission denied
> echo -pids > dlgt_grp_ns/cgroup.subtree_control // pids was unlimited now

You could also have increased the ancestral limit (if there was any)
echo max > dlgt_grp_ns/pids.max // similarly allowed

If you're a root (or otherwise have sufficient permissions) and you can
_see_ an ancestral cgroup, you can write to its attributes according to
permissions. Thus the delegation works via cgroup ns (in)visibility but
cgroup ns root is visible on both sides of the boundary hence the extra
check.

I can imagine that a container runtime process could enter the target
cgroup ns while keeping visibility to the original cgroup ns and do some
tuning on it before it drops any pointers to the original cgroup ns and
exec's delegatee's workload. (But it's only my imagination to illustrate
that this may be a breaking change.)

OTOH, I can see why this would be consistent with the migration rules
that exist between sides of cgroup ns, so this could work if it was
hidden behind (another) mount option like 'nsdelegate2' :-p


> @@ -4134,8 +4134,10 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
>  	 * cgroup.procs, cgroup.threads and cgroup.subtree_control.
>  	 */
>  	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
> -	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
> -	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
> +		ctx->ns != &init_cgroup_ns &&
> +		(!cgroup_is_descendant(cgrp, ctx->ns->root_cset->dfl_cgrp) ||
> +			(!(cft->flags & CFTYPE_NS_DELEGATABLE) &&
> +			ctx->ns->root_cset->dfl_cgrp == cgrp)))
>  		return -EPERM;

Could you please also update the comment above, to describe the boundary
vs subtree delegation?

Thanks,
Michal

--h4mii6pqtpg374fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZro+4AAKCRAt3Wney77B
Sd24AQCtYyNoghU23S2UhGQkLlhFQwtvcPbBgGyUFV3KGPv71QEAmQF4G1iz9mVD
jzSjEHNoK1ZkG6P/rFyevQ4p6kUDMQg=
=vF/P
-----END PGP SIGNATURE-----

--h4mii6pqtpg374fr--

