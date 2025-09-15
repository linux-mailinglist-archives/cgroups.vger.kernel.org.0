Return-Path: <cgroups+bounces-10115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D9B58474
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16A61AA766F
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AA2DBF5C;
	Mon, 15 Sep 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VyAopmCP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED12C159F
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960471; cv=none; b=mO0Fbo67mEErwLA+04OhoZlQ1V2ppmm8qO/oii8IRBlowfIHKsxaEYqJnF4XUiqs+CNNpQu9Bz4d5Ak9phc61/B1IDqnVAdzHnfPyc6DZNRAsi3GfriYq1oZ5fac8YMfs/WtBb5NOlwME/BwDAobbUAq8A/rKPDCgr8wUCtjZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960471; c=relaxed/simple;
	bh=0aDdECbcFnvzK6gvTk++iDWF1gYYmeS5TIpHZBB7Yb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtHXyFVNP76v91t3+Y6eiiI/yNGWFSaoaAacmGlzuoIpOWjkiO8WsVq2WDNGZDXeNdM3Uia71SUapePG8p2Wi3Ejz/SmNxz3FtjD6O1RXahVTZbtq7kUptUdyMbF7a5K9f2jTfhtHJui425GnWkVX2JdFVKAWiEtOAewbiQSdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VyAopmCP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72e565bf2feso31442997b3.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757960469; x=1758565269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=VyAopmCPFu7azUOHo0iM0H7C1iay8VW3m34YkV5/b7mkIrzNgdYj5gIB3MfbOgXNdw
         An1WLWvxpwHETRBOl6tExv14asHr/pcrwj+azTUyrRbWDdskINTs5rsmOapntNqNXL95
         t81vuvAhPUOVXnTPbrGYMDEg5e3GgK/d72EbDKkpXRHbEahmQtKj5f/MPk/JGqiHY7Pq
         En+4QRjrwFfGtSEBIVtYCHLnbd1yI+elNGt3Lf9l0fJMxlbjMhQIfYtIIsyzRsBAdvNH
         TG6/v5FypG6rdlO1ex/QEMEoZhYXH47Yn/9WI67xG2S1GDFt4p3nCwKGtO8N1hyud4OA
         XhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960469; x=1758565269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=U6So9MeJHOxm/QSMb8QLHi7r3eCwn7JDgguKrB5n3aEOCPJPr+5EGQcFeXarsYY7zi
         UGsAyddNGt+cjJQGBWU97wWYyiwuxxd/oZLG1LjoYcAbi4lUqD/7VxQaywOjMt1cN73z
         rI9m3hrTAg6m0E8nrSyJittPIb9E6oqcG49VQPSpZxKTIRRg93BOBAJLSZF7USbLhu/6
         hza/HwnN7vlzwcLawQmeewP5TgZVik882fNcFAuDCJjYM6t3JaV9C7ka8B85V7JwRwTL
         5+eT6vxDkGcvPW88aVdYFjysUpI1jra+gtEKeFuT/nOHBWAk6X3jdD7HieDZjZxI6ZHO
         SvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsOZJJzmgDwGihJgIboYQv+rzpvmRLCMHMCi/n44zWRPwj2NrQsg523f3KZ6wqDxzehKJYmOMx@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyKwTrB8lI+rWmO8MDa0EY6Q1Z1DWJkCHL/EA9bauN7r4NBY5
	CdD4/tx7OgzUTb8sBT+v9ThQLvXvEX6guJtypeBS2jwC5AjMhtBVxylm+NTHkPwAAsjYcpbMx8D
	uIS6E5Utlkpq7XmpPUJx7tS4ZhB0U9nwb/Jx9r0AjkQ==
X-Gm-Gg: ASbGncudTl9HgJzjY1FS2tyTjlgBd67Z6SP8Z62arvC5hpWBMS2M4mtGqyHkb5mvd80
	CDtls1zxLHrPigC0UBrDkSPgST+pkRexpv7mmlSrKT3Y7TaTwZa/G9AMKViLAh0OpceCgpJEsKG
	53JqIf3otbj/96E4ja5mNcAuP+85oB145PP3Xe2J/Ld7ukuJ24KT65Lr4HbsG/dzDU8e31J/TGO
	Cr30JTdTIzp4C0=
X-Google-Smtp-Source: AGHT+IEDp5ZYxkbjon4yCrRZanz3ywO+1Dqvmg43vzDGc4l+oL6FL33NrpAa1korZr0/WJwLYzGBFv1kfMtD4v4LVjo=
X-Received: by 2002:a05:690c:9c0c:b0:71c:1a46:48d5 with SMTP id
 00721157ae682-73063480b69mr133022797b3.21.1757960468639; Mon, 15 Sep 2025
 11:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com> <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
 <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com> <20250915142612.1412769A80-agordeev@linux.ibm.com>
In-Reply-To: <20250915142612.1412769A80-agordeev@linux.ibm.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 16 Sep 2025 02:20:55 +0800
X-Gm-Features: Ac12FXz4gtGN6Jqt9p3sI4NDKpM8RKfj3WgCz5dLwYdzbiuc_wRBtKzbSNJCafg
Message-ID: <CAHSKhtc-514tQoyCSukK1sLbDbc+Ne_TnwEks-h+gQWv8ZKHOA@mail.gmail.com>
Subject: Re: [External] Re: [linux-next20250911]Kernel OOPs while running
 generic/256 on Pmem device
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Venkat <venkat88@linux.ibm.com>, tj@kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org, songmuchun@bytedance.com, shakeelb@google.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mhocko@suse.com, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com, 
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:26=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Sep 15, 2025 at 07:49:26PM +0530, Venkat wrote:
> > Hello,
> >
> > Thanks for the fix. This is fixing the reported issue.
> >
> > While sending out the patch please add below tag as well.
> >
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> And Reported-by as well, if I may add ;)
>

I'd like to but I will resend the whole patch which is used to address
another issue.  Thanks a lot for reporting anyway =E2=80=94 it=E2=80=99s ve=
ry helpful!
> > Regards,
> > Venkat.
>
> Thanks!


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

