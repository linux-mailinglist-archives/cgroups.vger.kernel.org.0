Return-Path: <cgroups+bounces-6947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA1A59CB6
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7D160F3B
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E522D4C3;
	Mon, 10 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dgA0oPCj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F3231A2A
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626877; cv=none; b=rp51fbN9yN4fWlE4ma962YK1nusaREt9PS0O4ZJabEabZP6//NIvZRPC4EGj3wIpVEjsw6FOJ6q/8E5CmcsW+aIYSQX3D7PI9D4GdOcR3O4wmVa8dsqZTyVA2m85GNZ0BTQ051K7J/9ayq07RGr4iE7DO354dhYuKmUO+R3apr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626877; c=relaxed/simple;
	bh=dq1XvillSPGnZAnwO8Jk6HlomInoRUGnAxVEhvsL/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9NKxfWZjAuj69rJBiLWymqFhioj64V1hl5B8B6NLpErpHD2gtoepf8wPrjsP517RUpK5vJ0bYE1T6T4n9IUpN4V+9EIMON0gHQubN/Sz1wuI3fVMcHW2hp5TSBCYCKzHZV46I0qQykyVSfpv1PTO0yUOfrrqalLRnXoyvs7eY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dgA0oPCj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2135472f8f.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626873; x=1742231673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heWFhlz+SWz1xH5kFIwmWzIb+nauW24lGHRaxh0Rld0=;
        b=dgA0oPCjX2IEdYB9UjJli/tufzml5YNIqR1FFkwh6Knn9+Q8gjFM2Yi1U+n7zAOSo7
         X2bbhm4lwiT9VeMPHtuzkVMq6EYb86MdoGN7udZvHtl9gIM4C58Uae3Te913L7mduFV3
         gcNQCeMU+J6ahrcpNZiFmh5cJKBmAkxwb7+XZPJ4Gs8jGGawN51ui2mOzoGdGOnKevnS
         DHPmjOBlN3OjeczFT8PSpQr0kULwuAJg6eg6PXA6D+eB1rC3t9tX3HGioiQTaMlaWCpw
         sfbQE/3RYXBH8hBpbquZyHidbqBQsibEuGt8JivRKHxUn4XtQ7DXp+liKQX8ZETGr8D0
         IUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626873; x=1742231673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heWFhlz+SWz1xH5kFIwmWzIb+nauW24lGHRaxh0Rld0=;
        b=lOGQYDF3Eq6VzhozWmBVM2CC5Sy2wJqNhkJi9fcbP5aOCq65iauCpG9s4XuxBsINUm
         WFwLjCWCatglgDbf9p0bgDLSPp3fQUweUPohULKNy2DXxPZUk5dS4KHjoTsulKxyMifY
         MJqIpuT2zGe9XR2v9vq1FeYYSeshA1ENZY8IDoBfa6YElSiO7XPhxZ9zbbepy7N6e9Vr
         gKaM09ykCiIkxk6U8z/MBqvj+wWB9l6OIylProAtLn58nQiLNVJnorRvtaE7Wwn0nZbV
         QCliEjSojY5UMIHSZ9TzPLrzDWuaZlJgWbtf6SmBziOIdpNjZaU43pbt2S8pyTziPxIM
         zCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWFCXeblZ/u+X6LXDnukeyOXl7f+O8xn2KkrQzmcKQ3t0scuyFftk7n85js9X9JZdiRUeKhVCIH@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbFpmhgIW1J75PoK3bcvR112aPRm+TDyEqxWi4mIiejHGHf6c
	0dcOHOPyfLI5g4n5iPNxjLS5krC5C8j+Vb92cpjtO6tTmVT4/BibK2B2gELW7Xw=
X-Gm-Gg: ASbGnctKI6GWP4n1PW47fsxs7cC/2+pyT8BNNE0L2jqeOfHjRvlC5DH1ICkZnQw7G6E
	5MAIFBwBCi3PXmcrJQXeHMd8BdR2M7qBIOoj0dDX9XG5yRqzMjIx+1d4W5w1INJNp3GM7uF1Qni
	BxeZ9gXElwkQbpkPBX/P64eGV3/wVGQ9bLUJMJ6H8pgT/fQQCeOPJde4ySeTwdD2Q1abWdbzZyX
	3yxxBOLirKxiyrQ0Gj6qU4NmfQOzBwsduEL6mTHxnCzgHssGjCtdr6DgqDRTN3NHReEBrcTjD/5
	goZOdgi5g0Eaij9SSJe//PQ3RmkRANnpfkJW5usRVOlPvCQ=
X-Google-Smtp-Source: AGHT+IHIfA6s47W3ZhsLWndjNxIG07Q9wUrct0SV7ZxC4AQ588su9NeqgtnaMCydV2H48+KZCdjFSQ==
X-Received: by 2002:a05:6000:178d:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-39132d77a7emr8940633f8f.5.1741626872767;
        Mon, 10 Mar 2025 10:14:32 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbab43sm15840796f8f.15.2025.03.10.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:14:32 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:14:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Message-ID: <2vvwedzioiopvjhah4jxlc6a5gq4uayyj2s5gtjs455yojkhnn@rkxanxmh3hmu>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
 <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axv77jbvbeq5oriz"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>


--axv77jbvbeq5oriz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 11:02:22AM +0000, "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com> wrote:
> Do you think it should be rephrased to make it clearer?

Aha, I understand now why it confused you (with the paragraph about
realtime tasks right above interface files).

I'd consider such a minimal correction:

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequency which should always be
 provided by a CPU, as well as the maximum desired frequency, which should not
 be exceeded by a CPU.

-WARNING: cgroup2 doesn't yet support control of realtime processes. For
+WARNING: cgroup2 doesn't yet support (bandwidth) control of realtime processes. For
 a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
 scheduling of realtime processes, the cpu controller can only be enabled
 when all RT processes are in the root cgroup.  This limitation does


Of course wordier rewrite is possible but I find the text as you
originally proposed unclear due to several uses of "only" that imply
restrictions that aren't in place in reality.

Thanks,
Michal

--axv77jbvbeq5oriz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ88d9AAKCRAt3Wney77B
SZInAP9Rd3zY18EcqWow8FjgpvFFozQcWGVRKThYkSVY8rgSLwD9GbCUzDgg1aDb
cFJMyU4xEzEHa2BFoC6eDq1KMLSZqAA=
=CF/q
-----END PGP SIGNATURE-----

--axv77jbvbeq5oriz--

