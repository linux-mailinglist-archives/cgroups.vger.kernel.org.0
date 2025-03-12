Return-Path: <cgroups+bounces-7013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A7A5DE11
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32293189711E
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097624A071;
	Wed, 12 Mar 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7DyJHdG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A712459D8
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786368; cv=none; b=uw9ZhWsdLo9kDoh9p00Shq1FTamJxn59TdvD94MVvs0DVTOAoAhsPfz+GYrTbKXwk/dGKDtWDGXb3puEne79c+rETXN0h9MrO0HB2kkiGYp1oQaiVdxqaSrPKC22StodFO6Ad6NPrcjP7i3o5dudf44cc7oBqBkKfRQRtGHQKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786368; c=relaxed/simple;
	bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGBkpW28QBjDIB5QmI8kN15OE5EUXpbOsdd9CD+QWVQWX43fAhoma6yovkyqvmzuSsBozFYiSxqnb9zQz+Iw6xmWIGTtv3gUzKmRMcq05YJhxqdTZIrqVw5ZGNB1ZBc9RY/0BOxe3Gpp6kUmGcHZRWlktSXnCXL6IkG2SAd6gNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7DyJHdG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
	b=Z7DyJHdGSjyoOt4IK2fwsxbtNj966Jt7mg8FIGx1jN3s8nW4pT9sckL0i9ejN2H8ub+lRc
	9KJ2aBlcoTFlCcXKXxt3Q0+gJQUaz6u19Jf5VgsOqkx4T3DQI662aSYgRvEV/+2VLMYP1Q
	RVpnM/7CPzCfSEgIHTo5G6nx7ud/rzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Xvqm4tR6OpuClrz2cQ4HJQ-1; Wed, 12 Mar 2025 09:32:44 -0400
X-MC-Unique: Xvqm4tR6OpuClrz2cQ4HJQ-1
X-Mimecast-MFC-AGG-ID: Xvqm4tR6OpuClrz2cQ4HJQ_1741786358
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceed237efso29832505e9.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786358; x=1742391158;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
        b=eRkOKgnTDEceLw8NOj1fOLsj2h1pkE59LcsPhbpQMV0KghAiKrFCKluwBwSwFaoj/7
         zRT9ziX+KE2dXsVsPzMqUKP8PuSU8EvDIJvQf1LqNYXC1tLatZDR2u+XRzKKv+JmiL7u
         NM9HZd55cF73S1ovb+hTzjWZr3c/LVvhzejfNAhEDcUvT5jGMjVOYgBffEEwwhrvnjsA
         G+5lukJ0QxFolLJNznNsSayGKk+6TBrOBNwjdtBrk+FCymErZJ3Zmjw5YTM/Q01JDSVL
         zvllq7Z6Sk+rSedipUfum3w3YxLYxFu1ceqlh78pMmLA7qk++1RPyIaj0OguEsSWDrQK
         RFRA==
X-Forwarded-Encrypted: i=1; AJvYcCX6b+5VrPij15hd4/weInFfbYwKBS+gQHEbXJvIZyipTAUIy3Qf9Gr83y8sv3fCZMJI/pELBmqf@vger.kernel.org
X-Gm-Message-State: AOJu0YzMklqeks+zdhQP1svn1GRAP7PDATaSQDG/KAom5Uy8G5ZgiXe2
	xMd1hfHQK5JqjjKLzb+7DUR/DtpFmJlZ0Map5XFpaPEWFR2iPAji0CrfUPDOtEOeZ+IvKiYTN66
	wjfLhOibAmrGphGDcR0WOFC+yubRyRHCZZ9VmkFvmNY1gd4KIT33GyxA=
X-Gm-Gg: ASbGnctrxa0vzus3aJ2BGDz6z29Io8hQ+BQi2igRUSkGrWSZfBu1DHECVrck+YJY5Ro
	kcgOq/kAHpATB+ZDLSoQoLVMeOvJeMJ9ExjoV4Nd0JN0TKX2EHTQitWdKqV4xa3TOmk/DxgHPYG
	2De96ZKqm6r/Twf8dcfbg0jlnr8/2wnIJuWo7aodsYASIF0ovAfO5eSSSaeflcYFG5/mNz/HKs1
	sYNATx7I0BJXV7w2e9B35kpnaMftqKssqfy1wZlNM9FCbYNbt4x0dqyvnxigewTeSMSlorOS/wb
	LvwtnqT2XeslN24pI8hQT00M5jQidCl/sRLigDgS2t1DkmElHH4C7qob3gFKAawL0X3V4gJYg0r
	+
X-Received: by 2002:a05:600c:4f90:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d01c22acfmr89314145e9.30.1741786357929;
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj/lv00k6O8Z7XqtZVfKnJqf26Eyg9PRGsqMCVAjmTJ26v/rbB0hCn9t0vfRo/tY47QmKkLA==
X-Received: by 2002:a05:600c:4f90:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d01c22acfmr89313885e9.30.1741786357539;
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5d04sm22057175e9.27.2025.03.12.06.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
In-Reply-To: <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:36 +0100
Message-ID: <xhsmhjz8upe6j.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:40, Juri Lelli wrote:
> The are no callers of partition_sched_domains_locked() outside
> topology.c.
>
> Stop exposing such function.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


