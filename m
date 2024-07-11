Return-Path: <cgroups+bounces-3633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB992EF0F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 20:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99E128405A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198D16E875;
	Thu, 11 Jul 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWjcuDWx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818B38398;
	Thu, 11 Jul 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723475; cv=none; b=PaLSE1qWaosII5bfJ70ucGL4H0yIx6ntC2RpMUSyuWvboT65HsctHeYPecPhWZtYg+OpeAaN8xfEupyngy6vcHul+48d5E8/QHKAZP58tNmjoylAb3icfe3+HbboU0lG5V4p5gO0ufe/I+tp+c3P04l04QUKqKlLqetlJGgFXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723475; c=relaxed/simple;
	bh=SEFCc513xCNJSG9UVFgYdr0OMgjdLx1OXfmbJqmjliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q72k0+ufvOggFoj2+mg/lb6eN3b+8P1CE7jM8h9txyLS6RRArjpM5cIW0NC2UKk+XB8L27dL/b++4qo7VqyZukuggU8CDpwjWCwAV5W8UcldIJ7qCIwd8iWYChlL7XScprigQs5m8ES8Di345+McJ4CfVGVU47VlX2RB3STWk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWjcuDWx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b09cb7776so1058170b3a.1;
        Thu, 11 Jul 2024 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720723473; x=1721328273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81F7Jmh/XxgGOMMJv6GwxpQ3JjZzTcsp+Xpu4neomkU=;
        b=dWjcuDWxsfVUuiF945u1ZCgmgACDVu/3GgmrU9cg9CBgaSyPFA59Luaqx7WPPrAq2B
         WUV8gx9p+VPW5Ddeni9YBV6JGlSiBcac1wBa3SlQ51vzMwhyBButUlVMXoGZjfTDxhok
         xyA+3ZZAl51/tDm0WKhoGcYu4KyGJef3Jj+QH9P+bKx2CtgsTmiCYydMtdYGDiHjIEax
         33a93OQGo4PmZiM6/prAXcBz4nNSxiqVXGbdaOJNYQXs024C/61k8XSuLhxvEpp8vFqR
         17+UCVwScx2Ib3PskNojIQEftZVvmlySk8rSgRP+hrSWSz39ewhT38xzTqNlRFRYqWMw
         8ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723473; x=1721328273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81F7Jmh/XxgGOMMJv6GwxpQ3JjZzTcsp+Xpu4neomkU=;
        b=qsemrLiIDZUbMzfSZXegzJeQNfv6pMFGPRYu6hsZGV8SUu+VYXFV5kUuXMnp1BL9G6
         ZnaSJIHebYMi7YLwFtJrzSf4/m4hYmje3CFy/xcxGs+C+jG7H8NoS913CCiUrOeqp6mn
         dlarPOi8qvg1qffD/oktHqS86nVLtAXm85qOyKQ8GW6aFjPRV/ZCfrD6/NObk2pcxuYK
         o/+dcZi049zFN5gE+xX4q31MndVcdERhAELOuW6TLZ2k5uHMZgoO1MlCUjAFgyhpFC7t
         NWEY8NWVPjkR28ZvYOUOxWvxHlowdnwn2J2xo3BmSPFcpBoM+gmhpASrWwPrNnHM8W3B
         mYsw==
X-Forwarded-Encrypted: i=1; AJvYcCWs6cy1Rx713wZGSOh/OVaCf9NgtYxfWwFNXmPgyX9h3kUuSnL7IjsXvbR2ERmVdhobtPamyiKXNkH8dyrRJLuDnhXIqxco0IZZ8wFLItFqODAv6XVRTSB7nU9BxFwb7d8MNB0DMsPX27luIKopzwXU9EQ8oYmyy81Z/EmE5h3WmA==
X-Gm-Message-State: AOJu0YyDEbRaK6NNLJKV7nVwHp/Ry+hPS7uMKj+mJzA2Ll9xrL9mw7Yd
	oHk7FHBUwS0z6237Ob6Ib0hIP3ONV4C6j3AU1eArii9XaJ3+0EJK
X-Google-Smtp-Source: AGHT+IGrNhyhr4lJ/caU15aCmXa8NIU4JW+ZCRr9qtS57I+xiOizFgSPzdyXR1KOhdGx0whGrYN7uA==
X-Received: by 2002:a05:6a20:3941:b0:1c2:8b7f:5eb4 with SMTP id adf61e73a8af0-1c29820c03bmr10025148637.5.1720723473090;
        Thu, 11 Jul 2024 11:44:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54ea2279sm3622293b3a.171.2024.07.11.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:44:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 08:44:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>

Hello,

On Thu, Jul 11, 2024 at 01:39:38PM -0400, Waiman Long wrote:
> On 7/11/24 13:18, Tejun Heo wrote:
...
> Currently, I use the for_each_css() macro for iteration. If you mean
> displaying all the possible cgroup subsystems even if they are not enabled
> for the current cgroup, I will have to manually do the iteration.

Just wrapping it with for_each_subsys() should do, no? for_each_css() won't
iterate anything if css doesn't exist for the cgroup.

Thanks.

-- 
tejun

