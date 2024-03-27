Return-Path: <cgroups+bounces-2180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26488EADE
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EFE2A3AB1
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC1131BAA;
	Wed, 27 Mar 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmCY8Js0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FC131743
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555998; cv=none; b=ij9XMlDElaUTq/9AFq4+M/Ze9IsLxkQhlHmVXacpiWAkR3nUD9/XsPdEosdwWUPpy2j4BJdwJQyRR5F9minYyc7VMiuizvUs7hvDDbdLDCRUJ4HJ6yLnoyf77adB7tyJH4jE/3KCerE8U0RZRWGBewM3WE5u6oWq3oTEa+oi2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555998; c=relaxed/simple;
	bh=J4kHIDLS/w/PKe7/jq+fFjDcc6/qclRCpvXZXG9OeIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8aazNa1sxMAF613MuSdbCKzOR9652rDhNHUd+qhBFLryElPCmwanz5WNHXLJUFzgckYzrFM4dIlFbjvAIhI2+hYcpz82ABZU/4ODRnqs3Z1xNb/WlZa2FbFv12V7HCLuB+67R0dk79wbrdEaBIrCk7ULV2HKlvSeZFotmzNw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmCY8Js0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0d6356ce9so26014995ad.3
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555996; x=1712160796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/s/FRuCV60IVkNKkbN6fSm1oXcyYh5zsO5JEuwguvo=;
        b=gmCY8Js0l1rj0JWrTRNeFfsNhMos8/wc70rgXIV4h3XB3nOBQux+qmzPjLTtAO1YI/
         +J6Q26pu5JKO3SqvYPEzjgg5z0diF97GFXjXZdL5gqwbUUs+yBOUcZ8bGXVBhR3VFiA3
         f50msXJJRlYZweL9s7TMhCDNKtllTjkVuOnMD187CAb+CDmK6u96ZbF1I1GOzd6aAwZQ
         B6tRB/6PjY/BmXoz3ztaVky+ernkiTf5qa4v8TKGsOpyu5o6IxQRYDXmx/15Odj5OLDa
         ypAr3mk1JmpAed1Lg7+PxhABi4GSBwij+3+wZqaYDu+HwybztwvyFw/zlLjZYYmDdavm
         sP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555996; x=1712160796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/s/FRuCV60IVkNKkbN6fSm1oXcyYh5zsO5JEuwguvo=;
        b=fmZucDH2f/rAgbduv+UOiJ1m/fe9ALjBNPLiPiGDNPVQSj3ZreQ7m2tsMPot9DwkfJ
         8L70QKwGHab60ib+czUurVCG2y8oHUECUuvUhFLKfmIVrTsOfddmjcVU+vke6R2WcL3Q
         MnvL3jwb7aHmk+nT35XdK06zqULkndZHAcF0m9clD6p/i+LXjyTXGd1e0iKDl4wI6Hth
         D/Q9T1Rjukcja9vjjcg9ZMKP/14TdSq1nZssTT64M7Gr7py4RZxK9SrRVWI0udmDDeWd
         3d58GRRqu464/qtWHJA5r/vgv3gWJ4PZkqmND3b23WMLDdM/iR8PiWj7lJnoVj+4S5f8
         oxbg==
X-Gm-Message-State: AOJu0YznNIIBApwXahRMWtPrZMO6FUdSDoznwDOpkSHa3d4iCcQ6/mOq
	sTJGZOnbMzWebSuviU6y1b4TxdvnLG6SlltUNbv8CK87qhtyB8EH
X-Google-Smtp-Source: AGHT+IHcIa8XVFukp3jr5l8079P0TkHMbZ5qikcN6f/VW/czVsgN5iCayNOHz+wlW3fmila8SWAYtA==
X-Received: by 2002:a17:902:d203:b0:1e0:8e7:3107 with SMTP id t3-20020a170902d20300b001e008e73107mr120771ply.39.1711555995367;
        Wed, 27 Mar 2024 09:13:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4d4e])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm9177882plf.76.2024.03.27.09.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:13:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Mar 2024 06:13:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: cgroups@vger.kernel.org, longman@redhat.com, hughd@google.com,
	wuyun.abel@bytedance.com, hezhongkun.hzk@bytedance.com,
	chenying.kernel@bytedance.com, zhanghaoyu.zhy@bytedance.com
Subject: Re: [problem] Hung task caused by memory migration when cpuset.mems
 changes
Message-ID: <ZgRFmfeOpKiHzBkM@slm.duckdns.org>
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
 <95a41821-6bae-4934-ac3c-9f720dc9a703@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a41821-6bae-4934-ac3c-9f720dc9a703@bytedance.com>

On Wed, Mar 27, 2024 at 10:07:23PM +0800, Chuyi Zhou wrote:
> > One approach we can take is pushing the cpuset_migrate_mm_wq flushing to
> > task_work so that it happens after cpuset mutex is dropped. That way we
> > maintain the operation synchronicity for the issuer while avoiding bothering
> > anyone else.
> > 
> > Can you see whether the following patch fixes the issue for you? Thanks.
> 
> 
> Thanks for the reply! I think it would help to fix this issue.
> 
> BTW, will you merge this patch to the mainline?

Sure but I'd really like to see that it actually solves the issues you're
experiencing before merging it.

Thanks.

-- 
tejun

