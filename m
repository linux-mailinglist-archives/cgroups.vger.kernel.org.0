Return-Path: <cgroups+bounces-3064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682368D7146
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B100CB220A7
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF03154454;
	Sat,  1 Jun 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyoW1L1P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC73152E05;
	Sat,  1 Jun 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261646; cv=none; b=gPggCnVtmwptkZbUI6b3V53SLla16snp2zybYpsQUv1voYw3URU0apvTDgT+zRtge9JMYJjzsjUkO0piy6HN29tsP2og2y+mAYNkx7K3AP59L9fyD0IsqukNLT7uO0LVk0IfRaLVV7SMjS95gs++22Mhy9gFsH0O+5Tqop1ztR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261646; c=relaxed/simple;
	bh=LZ3GDWpyd93YydDtOYzkZD4KocTVxgezuqt2lbVIKxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFqGK2IrQRvh8xi2j2UXYuuLxw12JBSrHZDMt0DcDCRIRGMfkuBPkUxBjJwl6mzqFSl9LCsZShm4XcIqzm10I2jOh+l3ehdGbEc4gOtLVM53AtmO+amH/ttcKe3S5dci5l4UdET0TyVY9eP01wanDkOdNirdRj6rMZGSFPKKIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyoW1L1P; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6818e31e5baso2382101a12.1;
        Sat, 01 Jun 2024 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717261644; x=1717866444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MXCJewXuaOb5JuphsoKQX5DhVjzwbqfBMtGCB+y5TU=;
        b=GyoW1L1PtByU8TQPiXyvbxcpBO9YLmloIQ030NvsUOTriuiKJjafu4SlD/FfUiANkB
         YmlPtyeIgBcVoMqsNU8DDTgBD5QDCcfwdiDzolVR7Ct1k+YCZleVJZ7jNOpn2alUVESu
         ZiGweV/PgdG2i0Q6qCwXK+z1Bb54I6nspZbYfrHocIvlWtqP7TkdgpbAeZH382x/Tgdu
         nxsHmj0QUHAbw2SbvepoqV5wYO6GBZQk0q1FYiPCJMiOIJqYIFonxEYC66a3AMzsm8ZR
         IQBL6jQbTDUNojiQT3TODvLQRX/b+FX14U404eBVO11rpoGSS6D4rZVQYBRp8gRBDDj6
         lPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717261644; x=1717866444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MXCJewXuaOb5JuphsoKQX5DhVjzwbqfBMtGCB+y5TU=;
        b=K7PZTdxFdI2oXwdIvj7GzUZ2YYTY+gVsPtHPoKsFjs3XISkK2hWBST9PyF3YmCBFTX
         9WdjV2ccaV+0YqIOSlavN/V5VBdJxbYty9pjy22fnCLJDQ1erquxSEVoawjIa8HSNEdA
         Ah9end/hOQ4EMEuhGHYd8C84ktcMRvLg2CUiYqdjRMTtn3mdd6A5rCaPGjCJjN3n11jZ
         eJRPr1n0hViaEdou3U4+/+9yH+hbJMdoSOlf6cxhTO7JKzrOUBJnD/IuuPfRAbNKeCdb
         4w4u0lcv9k9IWWe4ZYj8uSb1lDkfQX5Ui4O6OQT6LXZTGlv++u/2Czrnwzg6ysfbRZsh
         1tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/0ASQrWOd4r2IWSIxxUvg3jgINVRabVzsBRJAer73mdjgB5QDba1bY/geEvvC5RCJGZMTXkPDW6+KrbXQ/L3mADbXjLWaf7j3EWfuw6yRbcA/cMZnB8Q44cdeCa6V2+NaEuQn5w==
X-Gm-Message-State: AOJu0YzB0vGy0AiYDWNNy2k4tcb/86w7PfxUDLYTk7UV5uQEJ5vH6EPA
	U5J2yAcA9xpuX7KZcmK5/Npn+Nl8uhdGEkeCph6Ift6zMkwoVGph
X-Google-Smtp-Source: AGHT+IEBppm1nOBktXDX3nc90gsPSN+Zjs8QGEOmfk/iQmwBpzbr1woDnWLKJCgSRt0bo5AX/Opkhw==
X-Received: by 2002:a17:903:40c1:b0:1f3:2d51:17a with SMTP id d9443c01a7336-1f636ffa8a8mr61979185ad.18.1717261643904;
        Sat, 01 Jun 2024 10:07:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f665929689sm2114745ad.151.2024.06.01.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 10:07:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 1 Jun 2024 07:07:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Reduce the lock protecting
 CS_SCHED_LOAD_BALANCE
Message-ID: <ZltVSizcmwxymwKp@slm.duckdns.org>
References: <20240525094648.1585086-1-xiujianfeng@huawei.com>
 <ZlOBAmStNZZU6Z-N@slm.duckdns.org>
 <da5bd6ec-f297-4d2d-8701-2554ef8118bb@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5bd6ec-f297-4d2d-8701-2554ef8118bb@redhat.com>

On Fri, May 31, 2024 at 04:07:32PM -0400, Waiman Long wrote:
> 
> On 5/26/24 14:35, Tejun Heo wrote:
> > On Sat, May 25, 2024 at 09:46:48AM +0000, Xiu Jianfeng wrote:
> > > In the cpuset_css_online(), clearing the CS_SCHED_LOAD_BALANCE bit
> > > of cs->flags is guarded by callback_lock and cpuset_mutex. There is
> > > no problem with itself, because it is consistent with the description
> > > of there two global lock at the beginning of this file. However, since
> > > the operation of checking, setting and clearing the flag bit is atomic,
> > > protection of callback_lock is unnecessary here, see CS_SPREAD_*. so
> > > to make it more consistent with the other code, move the operation
> > > outside the critical section of callback_lock.
> > > 
> > > No functional changes intended.
> > > 
> > > Signed-off-by: Xiu Jianfeng<xiujianfeng@huawei.com>
> > > ---
> > >   kernel/cgroup/cpuset.c | 14 ++++++--------
> > >   1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index f9d2a3487645..315f8cbd6d35 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -4038,6 +4038,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
> > >   		set_bit(CS_SPREAD_PAGE, &cs->flags);
> > >   	if (is_spread_slab(parent))
> > >   		set_bit(CS_SPREAD_SLAB, &cs->flags);
> > > +	/*
> > > +	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
> > > +	 */
> > > +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
> > > +	    !is_sched_load_balance(parent))
> > > +		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
> > The code looks weird to me. It's doing the same thing under the
> > is_in_v2_mode() block and the cgroup_subsys_on_dfl() block and the former is
> > also run when the latter condition is true. Looks like we can get rid of the
> > latter block? Waiman?
> 
> Sorry for the late reply.
> 
> The handling of the CS_SCHED_LOAD_BALANCE flag is different between v1 and
> v2. For v1, CS_SCHED_LOAD_BALANCE is default to ON unless it is explicitly
> turned off by writing to cpuset.sched_load_balance. For v2, the state will
> follow its parent when a new cpuset is brought online. Since is_in_v2_mode()
> can be on with cgroup v1, we can't group the two together.
> 
> I agree that we don't need to protect the clearing of CS_SCHED_LOAD_BALANCE
> with the callback lock. So I don't have objection to this patch.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

