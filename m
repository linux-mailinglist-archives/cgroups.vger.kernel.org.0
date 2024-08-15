Return-Path: <cgroups+bounces-4303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAF952E08
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02F81F24CDE
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490519D894;
	Thu, 15 Aug 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fIdKsdT/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3817BED7
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723934; cv=none; b=bz5tbU/WD82HvuILz2dWNMIqwvDlmkFdiJrFsD167Eei+r+HTQflbwKA4FJHe39rKlMPfKjuU5MsbRD7Y62uk/at+l+5CakWsiLpDgH6ienppTrUIU5pmeANpueifcx0fCSAnoXegK7EJr3uzR9zabufYrBgO5bNPLb/uMpILGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723934; c=relaxed/simple;
	bh=4F2So3gSOCe5aII/d2WRNkmCRi7ztmAg4uhSSeE0pys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOsuUK8lZo9LvYLfiaNfEbBLYm0hTRs0ZoUDa5nvc+6brRmr/qJIKpq7JIlBfM7w+p5jH5Y78CPVnwPL6Gvc3cH+oymKjQ+yh7oIbqGfaZDNFxF3/M6maYexEU2vz0frXaoWhIWIoTFfppdpqRim4qIvrbx7zTXYdckJ49EZ6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fIdKsdT/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3686b285969so441627f8f.0
        for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723723929; x=1724328729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yCAUly4N0kCcaUHvaqP10baf+HZtdpzadnBCSjdMFA=;
        b=fIdKsdT/XL+EPjyqVJEwXeSOEvVviRxns3L3sawZiRWVTOtTqMQ0FGKAFtHimR5f9G
         IKHOmfQmB2Qm2IP5J0aIOEVUt1i+m2PIsayHKDMBs5L+ns//jtVYaVk6ciq1R7k1pnkS
         sQlWHCUbWcbDAa5BUjAGdoF6f8O2GRerXaU+q/A4atuma5HL/VsbS9oYGCT47BV8pcsT
         o2sn68HD2iIxC43+7SUOVtbhjzdB7rshJNT7Sdgg61t2Fr7B1a/qbz7ySREZGeF6N7Tz
         ZM73NeZqZ1FZgbTuNkl3KyhAMfeG2BsIPUKb3OPp+UzU3EvUTa0CLu5sWyq10U7RrhIR
         4n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723929; x=1724328729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yCAUly4N0kCcaUHvaqP10baf+HZtdpzadnBCSjdMFA=;
        b=P7xmMcxuVydY4MRdBlXJz1qT4q7cfIyZLeITeRf5GqFKs+IGinkk1QXB3vG3kNTC6e
         dztLL088VyjV3NjNKKlLFWcRNEH+/RFK95n1JdI+5oFd1E3FJYu7hSow0XT+lkRTFKzG
         d4NOHiJPFdMMNoQ/NBHzrvWW80F+LoTuLhDdzTgYqWASc6CihUdruTnF5AZ5Vw+hjPw7
         uoGiWiA9Xq/K5djUjcR+vYnJuM3/4JUGQBeHY3Xl6osjxFAMOveQ/uYbnsUIT37qB/ET
         yK4A5JIRmuUAgz9bwmv7NI80IbBJbbsWjswIUfXgUCgDlXcB6CoJ0nATkrDadqykJIoC
         y1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcdLqvUknCInt8hupS77OAS+5iY51LunTTbTD2kvl10eSyRGdhH3nzLhZFzQhiLKUt7wa5abQSSRxf6JpmMcq0efKG5ro1fw==
X-Gm-Message-State: AOJu0YyoSwcd7/HgHTO5qI3uUNZKssRp4U1583UXzTixsZb5O2NI5BKj
	tWMxQdR343+T9yHjA6iWUBDaVDrQoKNC9KxVWtrEr1N7N8z1DzRQzRBzNzhMIJw=
X-Google-Smtp-Source: AGHT+IGPXHPYOeW1HXsCdkbC7xpvAYL1iWQKxFd01NY1rKx7X2iVOIp68SI/F6WfhY7EQVhdkiALtQ==
X-Received: by 2002:a05:6000:cc2:b0:368:3f56:b24a with SMTP id ffacd0b85a97d-37177777818mr4470418f8f.15.1723723928559;
        Thu, 15 Aug 2024 05:12:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabe9sm1357988f8f.92.2024.08.15.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:12:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: update some statememt about delegation
Message-ID: <vrozw5w2l32ni43akbf3xceq6rqpkskdlwbp2ko32qxv546n6s@qtw4l3qt357v>
References: <20240815024118.3137952-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bcwowopfy5kycog4"
Content-Disposition: inline
In-Reply-To: <20240815024118.3137952-1-chenridong@huawei.com>


--bcwowopfy5kycog4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
thanks for writing up on the care needed when you only use namespacing
(and not de-privilgation) for delegation.

On Thu, Aug 15, 2024 at 02:41:18AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
=2E..

What about some more clarifications to prevent other confusions?

> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -533,10 +533,12 @@ cgroup namespace on namespace creation.
>  Because the resource control interface files in a given directory
>  control the distribution of the parent's resources, the delegatee
>  shouldn't be allowed to write to them.  For the first method, this is
> -achieved by not granting access to these files.  For the second, the
> -kernel rejects writes to all files other than "cgroup.procs" and
> -"cgroup.subtree_control" on a namespace root from inside the
> -namespace.
> +achieved by not granting access to these files.  For the second, files
> +outside the namespace shouldn't be visible from within the delegated
                         should be hidden from the delegatee by the
means of at least mount namespacing, and the kernel...

> +namespace, and the kernel rejects writes to all files on a namespace
> +root from inside the namespace, except for those files listed in
          inside the cgroup namespace

> +"/sys/kernel/cgroup/delegate" (including "cgroup.procs", "cgroup.threads=
",
> +"cgroup.subtree_control", etc.).
 =20
=2E..
> -	 * except for the files explicitly marked delegatable -
> -	 * cgroup.procs and cgroup.subtree_control.
> +	 * except for the set delegatable files shown in /sys/kernel/cgroup/del=
egate,
> +	 * including cgroup.procs, cgroup.threads and cgroup.subtree_control, e=
tc.

"Marked delegatable" (meaning CFTYPE_NS_DELEGATABLE) is appropriate
comment in the code, a reference to the sysfs file is only consequential
to this marking. A minimal change would be like:

-	 * cgroup.procs and cgroup.subtree_control.
+	 * e.g. cgroup.procs and cgroup.subtree_control.

--bcwowopfy5kycog4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZr3wlAAKCRAt3Wney77B
SYgkAQDi+rGC52GY+8zk5860MbybdOCf/OUaIjhU0lKpi2izwQD+L/9YZiGh3RIn
X78l/NkWNv6dtYob/r0ddQe+fOKmug8=
=A2Y+
-----END PGP SIGNATURE-----

--bcwowopfy5kycog4--

