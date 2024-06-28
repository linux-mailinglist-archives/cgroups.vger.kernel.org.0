Return-Path: <cgroups+bounces-3446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099891B9A3
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A28284269
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695414A0A7;
	Fri, 28 Jun 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JvjQF31Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D07E761
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562505; cv=none; b=qg1IpsdBvl42yCO2Q6T4Ruaj4FNtVlrNZvpSWtlocmWLYjxnbF0l2aGRO65jeVfbEkvt5hMs5JckeIps2zxNrSuquzB4g3O65hnbhn/wE7BbDekM9rm+GsKd6pFaDjHB08xrOA/3QzNAyirciUdld95fFZi7DGR4221iVcNOCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562505; c=relaxed/simple;
	bh=pTUeXVvagiAOX0gsD6IPogOu/97cu9jgdrjcH3WYizU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwO0NFoxFQz1ykoQ1Of6tlRG7dB7wVJ9zLGXKRWOCxrO8Rq+aJ5dnzFHIgiu7JbZtF49GDL1b2KEp5nWp5MMCzWaFW1hNWmBsz7df+nfIpgfUFjbxknk/BFu55ychWjK37jTXkQ0ssr02l0Tvny0e/vpgIRKukcUcPFnKNQfeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JvjQF31Q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a724a8097deso35765266b.1
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719562502; x=1720167302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqLlOcQQA1EIzNXkhLBuQWSjSlMYijdUt29humv/fBI=;
        b=JvjQF31QMZOTMgD0gBKyooJDTcwdnDnrhdZ9Q26oC7EHz/qjJm3PB2FLNlbPAkbLHH
         LqahhRebSd+XRx716NeMuYGRN/ev48M3VU6jzC2oSlQPA8w25xQI/sehcFCRC7/AxuRL
         H9wrqX4lqr+UfFVsOoWy/3x+xpnDZ9XbEd+bfg3X/sRtO6u1WA4f/iFrzrfUKXLcyte6
         ojG2j9m2Nyt3cf2jBaFelt0DDAeMUUMBA+i/DLYgjb1OeS0QKVK9+TzK8qJWG68+BEJw
         c6YvmKiYcD6GXkqYkGzLxcB16/TkhMrkoMgB04hqPYMh+ncMRP+C92fdTzRviVMxm14y
         78VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562502; x=1720167302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqLlOcQQA1EIzNXkhLBuQWSjSlMYijdUt29humv/fBI=;
        b=uK1Swsb6rj3eek4poq+OWeHIToUWeXSIwzxsVWWVr1S0qnOsgVZYZqaNS1JsSs2S8+
         CtrLlRbKLgXBWLuXo2JcA74R/Fh22Rm1Wl0tpcJDnjomorhg3a+j4bNA3pWkJSwar4/a
         gr9D8n8w7VLfOZuvTjI5Eua3LcwYv7pzoN2ZyzFywBHwUt93uKeAeZYy6cDimpVsYMUh
         XWFUp4jHVRS+Ax3IvhkL02Rp6anQj58ary9KrTJkQW5uPcNXXgkNOcSvYuDTzThCA6hZ
         OJGF3GGfokTsdFvYbOaGUGRQ5RxetNtUslSltJXVHXTNoya0FcQQLktiLJo7VmyO+Wub
         pIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhm8fMFZWF6DGLsd2FaCw6ibd/AkYIxQ8xaWNg7G2vbq55yA/LjGDIII4a5TNZYJTum4EJxEfVQlccnbQcQ+jhET6ajFjGwQ==
X-Gm-Message-State: AOJu0YylvzXOc0vM5WQjBlo3pWX0KSOs2Z2yE0sTPK1sXKMF4RmqlC49
	fUeTC7tNfo0fEWahrC1XFE64eWWIvJNSPh8xT4boQcsXQ3pNRraU1wK0dMbkTvU=
X-Google-Smtp-Source: AGHT+IFtrZNHvkM+1D5Qqnw97MEaBSYKkXSf4YD5eSBkUIwju0hMYrI/Lg+SsBts/4RTOO7DdYI2Jg==
X-Received: by 2002:a17:906:6a85:b0:a6f:9ded:3200 with SMTP id a640c23a62f3a-a7242c4e28cmr878310466b.3.1719562501987;
        Fri, 28 Jun 2024 01:15:01 -0700 (PDT)
Received: from localhost (109-81-86-16.rct.o2.cz. [109.81.86.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065241sm52910366b.108.2024.06.28.01.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:15:01 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:15:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: adjust the warning when seq_buf
 overflows
Message-ID: <Zn5xBNY-Z4eNTCAL@tiehlicka>
References: <20240628072333.2496527-1-xiujianfeng@huawei.com>
 <Zn5qELsJZ0CrdlZA@tiehlicka>
 <0e44be2c-7039-710b-202f-c452bfc3f1ad@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e44be2c-7039-710b-202f-c452bfc3f1ad@huawei.com>

On Fri 28-06-24 16:09:02, xiujianfeng wrote:
> 
> 
> On 2024/6/28 15:45, Michal Hocko wrote:
> > On Fri 28-06-24 07:23:33, Xiu Jianfeng wrote:
> >> Currently it uses WARN_ON_ONCE() if seq_buf overflows when user reads
> >> memory.stat, the only advantage of WARN_ON_ONCE is that the splat is
> >> so verbose that it gets noticed. And also it panics the system if
> >> panic_on_warn is enabled. It seems like the warning is just an over
> >> reaction and a simple pr_warn should just achieve the similar effect.
> >>
> >> Suggested-by: Michal Hocko <mhocko@suse.com>
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > I would just squash this with other patch removing it from
> > memcg_stat_format. But this is up to you.
> 
> Sorry, I might have misunderstood, if you can squash them, it looks good
> to me, thanks.

Andrew usually can do that even when the patch is in his tree. But as
I've said having 2 patches is ok as well.
-- 
Michal Hocko
SUSE Labs

