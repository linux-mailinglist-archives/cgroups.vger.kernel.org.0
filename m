Return-Path: <cgroups+bounces-2228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31211890705
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00C229E407
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35B7F7C9;
	Thu, 28 Mar 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv3RCmsO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECF5A780
	for <cgroups@vger.kernel.org>; Thu, 28 Mar 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646383; cv=none; b=Uiczoo7As78yFXgh5pxBA9bCeIgJY2oG+89QZo23UGSgQl3kRxek6iNd08cvhJMhzRsD2IiC6ca5Gica4sZfsrolYpT65aoD3BC0s8MfPUMyRcqfI5ZnL7jZdEQGM6MtcXN6+4BxqmUqV+ev2WIDlQFwdKhJrThQLU6j2HoyEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646383; c=relaxed/simple;
	bh=BZy0e/HR+pWf3mz25qycBa3sXr1+PebgKxFTS/8vQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paD4cL9xQmXJTzXs++xOCXJK6pGz5ChiY3N8aIAXts7+B/O32PfZL2QrpY4Wfb9P+gP5F9isK0WXbP0wfPxtddfyucTZJ+mZW50c80ahqayLBnB7zUYozXHnt9NT95JXmY1edcRisV/T4Qz570HdSwvPwGeT9zNITjDYKkGqHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv3RCmsO; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6d089f603so772559a34.1
        for <cgroups@vger.kernel.org>; Thu, 28 Mar 2024 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711646380; x=1712251180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfV7qShhatNrGXBe7b0YAYRKlqVZCrAHczV6YxdU+OI=;
        b=mv3RCmsOiHpxouJr9otseY0cogaxGy+awTEwaNw9VjJpHHAmieEwqgl2A0rQUrmRs4
         k+S4jrH0iBsKSeTUS84/47pfzKGtkFsa8yC6ZQH045rJahT0dq3gJdbDKVGdKKfzOBqm
         VOY7T1iynnTVz0mOEvqIYoMOaBcT9W5glZzX5H0NQyOhKxu6ehlUksYVsTDTtI2r/ApS
         67vgM9GF2vnT4AZhW1KKu78XA2a6Y2T9DwI2RKJwPIzLhgx6rVcPEHhwW3LZnycG9Jt6
         zd2ukdWGakU6+/hKirixR9/TGXEi+CaCZSa3g5bHTe6HyO7EXQeYmj73182Dct7YpZm2
         rRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711646380; x=1712251180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfV7qShhatNrGXBe7b0YAYRKlqVZCrAHczV6YxdU+OI=;
        b=s+VR6mG3cYtp19PtvgxlhgaFEos6cp8KS+rcGfV2+agd0AgwSZ5paZbTBzgfP5Pjwc
         jK0/Hgr/tpeXrnc48FqxE8t/R6MoxdnOwy9w7GlFuMTtTjmDK6p+QtrmUEMo23NL6oNw
         sslEn4JJAGJQDjPE8MkKvyzKm0f8BvdhjyjOfgQ6vsd6YaH5uWPEJy3TiX2AlplUSwGK
         Nkg0+pzuUaQ9T8X6j+A44RwfPmFFwJ1JijhbQT7G7jKCM0qx+gbQHPWG3AuBHyMbHpOQ
         Kp3tFNe+7xkpsRikln+nggBEQKs50tERObVIRyk01wTEpCLhYyUfTQ6z1JV/sk63Gtit
         qk3A==
X-Forwarded-Encrypted: i=1; AJvYcCXlzRyZG1lwmTI86zJdMapm2exAI0QhSbR8lFHsaF2cBe1I+GfMTBYPXO5kxobweM3mBiEViNFk02b2l7IQ5WIDxoSouNVb5g==
X-Gm-Message-State: AOJu0YzupyYW2VmQH1X6ay1zUNBSbbe12saIqErSPLdSwgPoX0qhuEQ8
	ZoPJg5KkjXkcxK+fB2lX6+oQthUwQW3qGEcEt3Q8EQ414NTS22dv
X-Google-Smtp-Source: AGHT+IFmOdQsoW1apEip9E2PFY45O/QAdNMogcsa29luKsarAQdr5m+rdSz79tSYeUX1a1yk0uXcFw==
X-Received: by 2002:a05:6870:d1c1:b0:222:619f:9510 with SMTP id b1-20020a056870d1c100b00222619f9510mr3838195oac.27.1711646380569;
        Thu, 28 Mar 2024 10:19:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4d4e])
        by smtp.gmail.com with ESMTPSA id e10-20020a631e0a000000b005dc98d9114bsm1552756pge.43.2024.03.28.10.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:19:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 07:19:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	longman@redhat.com, tj@kernel.orgv, hughd@google.com,
	hezhongkun.hzk@bytedance.com, chenying.kernel@bytedance.com,
	zhanghaoyu.zhy@bytedance.com
Subject: Re: Re: [problem] Hung task caused by memory migration when
 cpuset.mems changes
Message-ID: <ZgWmqmIXwdN43cUl@slm.duckdns.org>
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
 <232747d6-2c39-4e2b-879e-9ac12445d488@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232747d6-2c39-4e2b-879e-9ac12445d488@bytedance.com>

On Thu, Mar 28, 2024 at 03:53:30PM +0800, Abel Wu wrote:
> > +static int schedule_flush_migrate_mm(void)
> > +{
> > +	struct callback_head *flush_cb;
> > +
> > +	flush_cb = kzalloc(sizeof(*flush_cb), GFP_KERNEL);
> > +	if (!flush_cb)
> > +		return -ENOMEM;
> > +
> > +	flush_cb->func = flush_migrate_mm_task_workfn;
> > +	if (task_work_add(current, flush_cb, TWA_RESUME))
> > +		kfree(flush_cb);
> 
> It seems we will lose track of flush_cb and causes memleak here. Did I miss
> anything?

Oops, yeah, the work item needs to free itself. Thanks for spotting it.

-- 
tejun

