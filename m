Return-Path: <cgroups+bounces-8901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6EB10BA1
	for <lists+cgroups@lfdr.de>; Thu, 24 Jul 2025 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DBD1D0005E
	for <lists+cgroups@lfdr.de>; Thu, 24 Jul 2025 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698272D5406;
	Thu, 24 Jul 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C/maM2lE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32313BC0C
	for <cgroups@vger.kernel.org>; Thu, 24 Jul 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364143; cv=none; b=pLAQK1dh7koSsOobSHwuKW4StRFXRM2V7LCq6ThsH7cfatF622Rdh4MfOIJxiexShH+ZmUA/+E8oQAJ82SGBHvR0iIpMT5TYvNet2ntW2F1nzTRz+eKDxquRrWSBmlla55XftmXfk6X9Nq8f3OeB+nfO8akmkgPa/qq5q1a9zZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364143; c=relaxed/simple;
	bh=vnOWbdLL57ho3ILUGJIlNNAJitfSpo19bpU1UzcEEmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfjjTuuGJwywzMwus10p+Ke/FUz+g9VwrdK62YnFmo2x/ClilLd7SaAZ7y8wTSj+eQg57FmaqkRPyRE8dc1eTYVQX34oeUsotPLgQbQH8dIR3cL5JDG/yTRq3CtCiZJWlQK9emVRBZdp7q8XMz8oVeeIAMh7+cpEGxca7Q2o4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C/maM2lE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso10772945e9.2
        for <cgroups@vger.kernel.org>; Thu, 24 Jul 2025 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753364139; x=1753968939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/783AWBb1WjprdR5FQ53MxE+lFAhfIuN35nrxo6hj4=;
        b=C/maM2lENVlS076xrfR+87Q7OMuv24LlcqWgnHhWHaRl5xdZVzHnewjm95yI28Sx9D
         jQltEgQwPXjAO/3wiIKFndgunXFj+GzG5Acn5bq8xZHUq4x21AqblmnQsnACKYydjHy3
         P69DoxPNJCzAY2uKB0iePfuNwySnFZ1Jb99UhkutWiRuB3Auv0wLNUHEn417O6DNvjeY
         3yZralpvK05dLeSLGfqgQL2qglk74zvFGmNWiv0MC3zvRPNHvX6LhrizinrlchxRTknM
         CLjQXSOT2ymzMAzDay+Q2gd+txpP/KzgfYtj0WANRsDdK10nld+lyTU+ircOgtusXNDP
         FM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364139; x=1753968939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/783AWBb1WjprdR5FQ53MxE+lFAhfIuN35nrxo6hj4=;
        b=ptgTA34Yup57Z1pFYnVNACZZb1mYy2btkgP9fvf8Iv5M13fwz9WG2v4XPBnr1O1OJz
         DuI2dU/wNOf8d6ZJWOyC/OcxKmR9iZ7NwvBG5MPZfyBg0dKJpG8QFnRtKDEDKcqFGNsK
         aPTwR7sl5I6cUOkG4FKQlTkbVUwPG5HMpIuLco/9NFqjh9Xn2XCFsLccji4OGDp7kI9L
         jjTpEsp2YvraByvcfe0riEkIqQiAysxq0ooWPtLr/PbEpIeVzZXC1liQ4m/GbSbqA4CB
         P+v0Hlog8wuEYCvawnKs/XJEqSf5JEGPU6T0cB3TEj1A1jSRfTNsRf/YYmmDR60uuKg3
         QyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9L8668SrZBvKu1zWiDMI/1xTI4DODGyA25e8G752xranyGDegiNKMuSpeaUX3IPtPkxY6uO9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9gwCYmE6W3PrvmgwjW95Jch3CXCNtBJQQ/Vc+tZTY/dvYNn6
	C3sa5Q/ayQWTjImDCyRHcApvx5D5B/E1EBwRL3Kz1B/KgtdrREr6aCWhwHOc5tuUKQs=
X-Gm-Gg: ASbGncuBGEftmaEwgFFteRZGTrwM9fmmwAb6rZIw6BtT9iVZsjTmj5el66Tue9BSGQ6
	ooCrHrqwCXeLx5Ifpu7EOycyWnusWlwGtTtvQjs0uR/CsfeuYW5GYtM/VNpQXn/WV0S9UEsztPz
	htI/SB38EHBeGQR+kxR2IExCRv0fdLPAw6Lvg975S8PldgtyUaHDPph/+Gs6/x//AJM3ykgxaqU
	8oY7TgtTab1pNAf0oUGhHrpkXt7sCqPAA9u+k9SJWTEBvb01sprObe4DWuyU/mV7fsEUv9mxOBA
	Ks3nYtOY86Q+uxlfMTu+0gc9Z7Wh1Bz5sH4WwyEpCYO9IkKViN98j8zJY5JJC1xwTzSrHY1fuXI
	oUaEnzm+jrCmARjYCdqX75Y/0TsY/8YgFcsW4jU2ptg==
X-Google-Smtp-Source: AGHT+IGx8P6YHLZgXnJMcaSIRXjWetfkIpZpQUcR+9cauLnkNbDKHnuiJIMh2QcEi9oeQa/G66Ef7w==
X-Received: by 2002:a05:600c:1c22:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45868d31a2bmr68939555e9.18.1753364139342;
        Thu, 24 Jul 2025 06:35:39 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcbe8sm22164745e9.17.2025.07.24.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:35:38 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:35:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com, gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
Message-ID: <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ig26ryr6n357ans5"
Content-Disposition: inline
In-Reply-To: <20250722112733.4113237-1-chenridong@huaweicloud.com>


--ig26ryr6n357ans5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
MIME-Version: 1.0

Hi Ridong.

On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> CPU0                            CPU1
> mount perf_event                umount net_prio
> cgroup1_get_tree                cgroup_kill_sb
> rebind_subsystems               // root destruction enqueues
> 				// cgroup_destroy_wq
> // kill all perf_event css
>                                 // one perf_event css A is dying
>                                 // css A offline enqueues cgroup_destroy_=
wq
>                                 // root destruction will be executed first
>                                 css_free_rwork_fn
>                                 cgroup_destroy_root
>                                 cgroup_lock_and_drain_offline
>                                 // some perf descendants are dying
>                                 // cgroup_destroy_wq max_active =3D 1
>                                 // waiting for css A to die
>=20
> Problem scenario:
> 1. CPU0 mounts perf_event (rebind_subsystems)
> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
> 3. A dying perf_event CSS gets queued for offline after root destruction
> 4. Root destruction waits for offline completion, but offline work is
>    blocked behind root destruction in cgroup_destroy_wq (max_active=3D1)

What's concerning me is why umount of net_prio hierarhy waits for
draining of the default hierachy? (Where you then run into conflict with
perf_event that's implicit_on_dfl.)

IOW why not this:
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *r=
oot)

        trace_cgroup_destroy_root(root);

-       cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
+       cgroup_lock_and_drain_offline(cgrp);

        BUG_ON(atomic_read(&root->nr_cgrps));
        BUG_ON(!list_empty(&cgrp->self.children));

Does this correct the LTP scenario?

Thanks,
Michal

--ig26ryr6n357ans5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaII2pwAKCRB+PQLnlNv4
CNfYAQCUc2XkchH6ARt6FKuQ6Im+lr37eUpJT5yuMPiiIyFMmQD/fAcBfK9p9YnS
RbU4g77pcS6SzZf54YpcCZZdzgPkWgo=
=nDUZ
-----END PGP SIGNATURE-----

--ig26ryr6n357ans5--

