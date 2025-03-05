Return-Path: <cgroups+bounces-6847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7AEA504E8
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C026168627
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E26253348;
	Wed,  5 Mar 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyFqjXu2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FF253353
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192061; cv=none; b=e7C0s2Edc7srUAlXyF5fEg66k8RpaGTsCCOucn4SLz18BgF7PC5Q9sWXcMy9N28Qc9smThUlMdI76hbRxE2JFMFa86oqdlX16CDFMUC1DCg9iT5ai4C2mkC/U+Ap5gdeXIDf6ey+Suvqq7VLlbjJFwUBeQd0mp7w/cmfuPd9xR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192061; c=relaxed/simple;
	bh=Vg7SCNGZuv6MSzX7s2TH5C/95lcIkGxtA3uOHTXdXys=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ojJPfshGgsSMB+odjP4lPWvFMisla/oLpo65kgAqpq0Yz3c9Rlx1dZYrz4ZyC9pDA2XP4ui/gLGUhrmv4ZIw/TUA4tZgG99StCXITVFFWDS8wAFodzUH6K9DMj0j6Gi+wuxyg+8mANPc9g642ABm5hRSQxAZciFre1mN9aMdPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyFqjXu2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741192057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
	b=DyFqjXu2WyCSpv5rqP3EOlHuAPYhasXXAK4dehLz75zOnbngQQvDr6XBkdNe8Ceq3Z0+Kk
	o4wOcyg0xsDs0wME3Wn4/zPVgpWGTMpVYYQ00T89Lw5PeXJgJpe0hIARlB7Ih4djj9OpSJ
	HkOz5imjDg0pCMRXcH0Vt0NCcUp01hY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-EGJTedbdOPS95OSqmEdy5A-1; Wed, 05 Mar 2025 11:27:35 -0500
X-MC-Unique: EGJTedbdOPS95OSqmEdy5A-1
X-Mimecast-MFC-AGG-ID: EGJTedbdOPS95OSqmEdy5A_1741192055
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8c4f5f3b4so91022446d6.1
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 08:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192055; x=1741796855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
        b=sauKkyNmYuw70evQ5PFJx/briacS7L+aNORS5yN12PSWIRagttV+Kx1MybE+utxCSz
         8cRAvVPBbRN/VGf+fHp17dLm/vTSoWAKRTFRClpwncGttoe+dr15W5WKww7g8axxqv/I
         eLJzR5OOEIkbKZKrfJ8XEpRs0F/QdVWrHYS0+6aF17AlgebFll+foa+HaustpAvarDU7
         pGoKL6yMyfLrW/4QB0eoOIhUCDIsj3p0KlzLIL/WQWVZZzJFKjm3GgWonU/VgLU2AskG
         qC1aa2DtvD5pxPir2wAKBLfW4jhznuk0GVAtY9PhFuHER9QWGBfssfm8wwZhPdlKsvkB
         VyMQ==
X-Gm-Message-State: AOJu0Ywmp9exKMJzr99nurW+DrcFpc9igFu9XUQVKoOOIR4FxQJzMOqv
	33Azi3tj4XZdkVB/I3OdW4YnAK7BQGJxRpwXJwjtGZTduxqiU1l75wd2g9gRU/NVaSh18AixQML
	YftiIZZbEz8g0kQUd0RjxeG30RNxQzp4Lkvle0blPrDdy8qFUOoo5QBmCDiWBmTc=
X-Gm-Gg: ASbGncsaWq9beafu9C0UoB1MrH4OboV2QKVtHSeVvqLaDIglFbWQ2bCE+cgASgM6gy/
	OylcBZ/siZPbeaMkILYaxCNjN5SVn9A1jxd7vsdwRNC859Fx1eCMcc26wEKoVEyJL+EQ9oF8Ylv
	N6exGzjS5r8SsTwMqgPh3wJC+Sl6SBkvJiUIcivv2Z0YBfRC7jtTZVx24Ir/XRgjgb4ewviiwAO
	IQt2yfDzDNi6/a/9Q2z6Bllp2Pz5MsLtb4NF3A841r4roV64KQD/b3iiSAnuqtsNifqgBPAe1Eg
	zSaXC8fiBbuBawDBtm5PSAlosD1EbsuvduvaY0fC98nIrjfAcq5FxVgNrxg=
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705576d6.38.1741192054927;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdjGMu3Z9P5awn0k+syJ1lGAzEkIPJ7IQ68O6zR7KcCUd+jJ3LYDcgb0Pg4YRM3PptFxn4SQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705186d6.38.1741192054692;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f401d4bcsm395776d6.124.2025.03.05.08.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9c24f14f-c7a8-490e-9077-0d977d175d89@redhat.com>
Date: Wed, 5 Mar 2025 11:27:33 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com> <Z8cwZluJooqbO7uZ@slm.duckdns.org>
 <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Language: en-US
In-Reply-To: <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/5/25 5:17 AM, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 06:55:02AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
>> warn whenever the file is accessed?
> I added the guard with legacy systems (i.e. make this backportable) in
> mind which start with no cgroupfs mounted at all and until they decide
> to continue either v1 or v2 way, looking at /proc/cgroups is fine.
> It should warn users that look at /proc/cgroups in cases when it bears
> no valid information.

I like the idea of warning users about using /etc/cgroups if no v1 
filesystem is mounted. It makes sense to make it backportable to older 
kernel. We can always add a follow-up patch later to always warn about it.

Acked-by: Waiman Long <longman@redhat.com>


