Return-Path: <cgroups+bounces-7728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDABA973AA
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664F87A2770
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD11DB13A;
	Tue, 22 Apr 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TKo/FiGH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D614C5B0
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343426; cv=none; b=lVe513Q8SyH2t9LdWoFtWT3RKLVIcOJCEa6aP7I91JqnwehiOY+X3mReKo4onm8buB32Zhh5gBg3bNe2ENr3P7uoYul2ZFb5lPlAdoDyJWrCO1uaSywlT5YetWaJ5ZSa6eaQAL8gRzRWmce9+IcJ/v0QxBNo07rCS2vAf/jKncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343426; c=relaxed/simple;
	bh=L1NuLC3M9iOVcIS/tnSiORX9C+uzimIbziX78n+Rcqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2qzwrh3O7yoCmBZWr0GG7MipVffhNIVejuvLVTTAkERG2TI0mXgb/5HNTOxiuP7N4z+AWPBDt9aLBjIFcphSZGEiybFp8dUPGeV28tQbRDbKwX4ljHJYfTIqUyi2Q/qo2HZAv/+eyjDD5HcXrDE0fNsEyVfrSHGFRBu6N54m+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TKo/FiGH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c7913bab2cso524317785a.0
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745343422; x=1745948222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGlejZf1M4uB6/02tIygWhA14axEik3yrFkQW21it0I=;
        b=TKo/FiGHh+AksseN8OCSZ0UA8zarshdWvPi95x11HTMY32Bw9mvzswkQ+oGPbxKUdz
         fTLOPhgO7MnufSTmSjfa9bnay4iUX93V6U6Z+jbBtIg4p4rIdH1ZMp6UyswJt4r695GL
         1QzLtZFwkSK9Q1ahMb3z0P9tJc0n465X2VZk4qlPPo6xFunWFJPBYhG1WyvRXodp+As6
         HisrQ0wyFoopRI1Zy22LRJsdwpx8JHzzz9u9xr2nJleZ+IUUr37S04sO3vF9Tlr7RiYw
         A+fRAP8BH99x8DW8dWBTrHT8yLP7Yto8QpIRlAFJmWLyx95zNaDXlaETfDANTsSb50ok
         c58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343422; x=1745948222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGlejZf1M4uB6/02tIygWhA14axEik3yrFkQW21it0I=;
        b=DFf9WH9Htrc0Voge8/6p7IftHcW7hc/uqihYcUe59J7hC4y5cnAZf5GitQXsvMShaw
         U6/slhdQ6C/swbDDdRquy5WF3nOQzs8qXed3hQpJtOOBGtwD1U9wcJjfz1cw9iPnZR5i
         0/Zwdg4oVbnB+I4ptfigDsK2imBr/HLCCPqWF7ut2bYMqrYtazdTKfnxgmwvPk61KDT6
         334WcIEJjOSGAz5JONSTpx9LtISKA3kf9BK1A8WK64w9iWc9xcrZ3trgtnNCjZlwm6My
         b7vkB2snCapZ8gjyTF8D/Ut5Dw61P03HrVWyi0c0R21K9IrnQTBmTwUpfV/EPaSiumnl
         C37A==
X-Forwarded-Encrypted: i=1; AJvYcCXJOWDlMPJReNT+YaK/xNDDIgpweP7lI6aoi6PtVG7Srsfel9t4l6ZZAGbmv7+oGeTzOnXx6BrL@vger.kernel.org
X-Gm-Message-State: AOJu0YylSViOUojWY3Auevx8G8VM+AxaTZ01EnvyC2/2kda0bI7HpN2l
	32WFTuUAyTNVVzhhBAWVtrL253vzZqp0YNPhMok0S+TpxnunigWtoAC9LsvpgT8laTYq5HlZ/bU
	dpuY=
X-Gm-Gg: ASbGncuKbXm695HX5XbQ6JJoEywOKap6uMdLpTabUD+5GmZr1PwUketTV1n/UiDqZBs
	PrWb9A9zU8Y5cWaYdarUc4Hm9xKYa7pu+7LShELTtVuq6czlG4sOun0LDlLC/R2+j+4LQtFb1E8
	wb16LMUMgq+JVrELKf7ZXxX4ahy9Dq92+awpj1/JN2pxWEsoc/7Rcc71f9pZUbV0NGR/S2kNB8Z
	zbkO+9FbNchhadxoLV8ECyLHOcpnbdy76EJ0vnH/4xVnsXkgmNaEKr5Vz90YhdIRU4Rx1c8eGrC
	5jIvzncx1CKeq4QYlSydeZzYKkMbA4WjCKUG8Jw=
X-Google-Smtp-Source: AGHT+IELDUlKcoCTHzBX8I9XSIjxg7eaS3ClKXEBzXDWD4aDyg2hvTE+Wb1eoZHRb6LlviHxQ+FBOw==
X-Received: by 2002:a05:620a:c42:b0:7c5:54d7:d744 with SMTP id af79cd13be357-7c927f99feemr2428682185a.23.1745343422011;
        Tue, 22 Apr 2025 10:37:02 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c9280de4adsm556929785a.114.2025.04.22.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:37:01 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:37:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v4 1/2] cpuset: rename cpuset_node_allowed to
 cpuset_current_node_allowed
Message-ID: <20250422173700.GB1853@cmpxchg.org>
References: <20250422012616.1883287-1-gourry@gourry.net>
 <20250422012616.1883287-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422012616.1883287-2-gourry@gourry.net>

On Mon, Apr 21, 2025 at 09:26:14PM -0400, Gregory Price wrote:
> Rename cpuset_node_allowed to reflect that the function checks the
> current task's cpuset.mems.  This allows us to make a new
> cpuset_node_allowed function that checks a target cgroup's cpuset.mems.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

