Return-Path: <cgroups+bounces-5745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD079E1D90
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948D6165E8A
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D21EF0A6;
	Tue,  3 Dec 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka02SE8R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81CE136341
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232593; cv=none; b=CKgFFMoyiH+iSmY145osCZge5jlhZ99QLiC4H+xVH+ywELWDC8snh9B/xGZTMzRdEJpIcMsDjk6v3vR/GIsC2hM+7p655PB5w+UTH8Q4Gbh1KQqP9PEX7hGAfSriXP644iY7gk0Qxm8jwt0lNR0GGHx7crTn/46oGCmaDDndUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232593; c=relaxed/simple;
	bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvrJpm4Zx+cn56lUVhvZXPz2vGKLT4UYc0MhiyzEOM+Xk2cMsLj/CFeozvay9dQEAXn36oTtPJLXgQmNdfmucbXbxk5bVUWyKeB7Tfia2pnnvwHAkZzQMapsd/FlrlvbHAijfyLIlOkgsW7APDWBo/zrX4S1ay/FZuvyoLfbMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka02SE8R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733232590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
	b=Ka02SE8RcATFDqs6ASaxwBel5G2PlKaXyOgbAuPvw7R9+YTiX0bWv1BsDMHPJr1S47jcMz
	HdLKXCNhKsB4d/g8Lhi+SpWiAfIdWwjh/QrezdmyVrrWLG9Cy7De7vMsGwGwpqCQ3kbO9I
	q3EaaUgxTdI+wFpF4wZQbA4iAqM4RXE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-yUmN0a4kNea8xXPDrRIClA-1; Tue, 03 Dec 2024 08:29:49 -0500
X-MC-Unique: yUmN0a4kNea8xXPDrRIClA-1
X-Mimecast-MFC-AGG-ID: yUmN0a4kNea8xXPDrRIClA
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-29e82572976so966209fac.3
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 05:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232589; x=1733837389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
        b=wzlFI/0lCNBnKA6H0dQ6R005vUct+ZyIx+phyWxiRCsmxSLlXMgleUsM/M9CiALdUa
         IMZB7ANULnIp8HBT/4YuNVBeVo3VgnCpwkZVeY07RILJkEMtcnN7jKh/O/c71REDCtQy
         SF+6hNqSAKfhyJ3gxNgfFLmD9XVWsi2d1L6A8+ewL63DLn/5dMwLlxSOcAgljyWn7kvU
         vecyMQv7bWUUdTWiMnti/ce7k6oatv9luiuHz9wVtzAfFo7tDcKRCQJvo6Ff6CZIs3m5
         H8ZjU/h4WE7O86nj2CVUCDfu4mII6KkXpCabu2RZq9cwXrvTdiiSfdv5fa6Nky6bXAdJ
         wKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcNzITpl+hL98fqR8sf6n8TO+Ls/2R439MGlx0JWMIy9LqWyonf0XLryZpbsNnFtjNVtU5rFYp@vger.kernel.org
X-Gm-Message-State: AOJu0YySm0Z7SVGV9KFtppj+swvS+mFU4x78ClSwCCAS0854F/MeGD7J
	0Fhd3qdKSw95BRpA+NHjOtaLPxyst2MRL6qTH0qK199RYL/vcIYUXCTMdJ2sOPa6WY++FF0nanG
	0C+uXbScKcWD16FPmn27ssAKSPmNIfM5n+sCpEgeOwfx1j0SC1Bw7bBOqHk7eBxCfwynz9yJ9/r
	toBmQ06PcJjoGiPdGvW0p9lnoFyx4XRg==
X-Gm-Gg: ASbGncujK///OQQlyK5wqx03y3LVnQ2i/u+lD3goBRPomlQSJ4WlSBpbzhvFdwk0vVD
	kccLWxAbWzDXuMVANPr6jjQZdgIPlQxbZGvrLKeyAWiAivdIBbhd9D1H/l4GGhDQx0A==
X-Received: by 2002:a05:6870:3b85:b0:29e:684d:2739 with SMTP id 586e51a60fabf-29e888946f7mr2186261fac.32.1733232588876;
        Tue, 03 Dec 2024 05:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFExfH2VrDltV7oN8LmeRawcdQojOLEdyX09vyUx2aadwBxD8ckIt1qPwPw8S0zuZPWUmzatJonWZ74bxlmRJM=
X-Received: by 2002:a05:6870:3b85:b0:29e:684d:2739 with SMTP id
 586e51a60fabf-29e888946f7mr2186242fac.32.1733232588658; Tue, 03 Dec 2024
 05:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203095414.164750-2-costa.shul@redhat.com> <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
In-Reply-To: <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 3 Dec 2024 15:29:12 +0200
Message-ID: <CADDUTFzfgrA3tjmkedxd+JWrK_rMLiuOZMH9p5-+5rmW1TcS3w@mail.gmail.com>
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does
"Accessing a task's cpuset should be done in accordance with the
guidelines for accessing subsystem state in kernel/cgroup.c"
means `css_set_lock` defined in kernel/cgroup/cpuset.c (moved from
kernel/cgroup.c)

Are mentioned guidelines now in include/linux/cgroup-defs.h?

Thanks
Costa

On Tue, 3 Dec 2024 at 14:31, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Tue, Dec 03, 2024 at 11:54:13AM GMT, Costa Shulyupin <costa.shul@redha=
t.com> wrote:
> > Remove stale text:
> > 'See "The task_lock() exception", at the end of this comment.'
> > and reformat.
>
> It seems you've read through the comments recently.
> Do you have more up your sleeve? (It could be lumped together.)
> Unless it was an accidental catch.
>
> Thanks,
> Michal


