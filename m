Return-Path: <cgroups+bounces-7535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A6A88CDB
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24287A87CF
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251451DC9A8;
	Mon, 14 Apr 2025 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qwr3Ibyn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7101DE3BB
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661497; cv=none; b=epqd8s/qe+8A/UN9Ca+4md/uo+mgIENcgsKwlCraQia0GPEfamE0thSIgJyxBtbs1/BFLDmQYKmK46PUny+aGLlAIIi/bxSBXhI/qxo9d/65+5N6kIMngRDZbREtlUB0elW3Xp+dj8/OnFhLu6qjCAE2bSezZ14kd1jmeJVeoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661497; c=relaxed/simple;
	bh=m9JPGoRtrzFiXzQ5JxSpphBesKZxdOJFyE2RAQr2itw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AeH0qliuADkJo3j4NcO4ec4gGtaSRMlV4RVEWax+jmSWlJSt8o5KVCQUjQk7DQ3O3ARMHEkyltlegbgaZRYkFSeF6sQrY2S5tjM4yMvSy2rg24iaXTKm7QukP1tl63inE1fqbk1RSZFoVA8La2UNjPeSPWeLy5TX97IhBsB64K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qwr3Ibyn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744661495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXBMNalW9AKD2lIVI1ITSnwY/4rOc9i7I/RBVDU4908=;
	b=Qwr3IbynYnfansnJj40EK7uITqpPlNCw6v87UnD4ycMJh2QXNSudZsW4j3CgiJ2ORQ5a2R
	nT9gzAFK1yEnmCT+i/0yMh7RRiNZekveUtdDuIolUufeBa4iQ2D7cT5gogGVW4TjDTEBTr
	EuRQcEaxk78POkVQVgPqD1QEVbUihuc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4gFBoPu3O6e8vtzVnNsXqQ-1; Mon, 14 Apr 2025 16:11:33 -0400
X-MC-Unique: 4gFBoPu3O6e8vtzVnNsXqQ-1
X-Mimecast-MFC-AGG-ID: 4gFBoPu3O6e8vtzVnNsXqQ_1744661493
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91b1ddb51so87721516d6.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 13:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661493; x=1745266293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXBMNalW9AKD2lIVI1ITSnwY/4rOc9i7I/RBVDU4908=;
        b=N07oID8ipCgHGLUIf8VKRh9/hx8moM4c+oYQFPcrG7LEY0uheXpD1Bt/JHr2bNH3Rg
         r4kjaZYk1c9XMclaWSwbPUnkAUs0ni4Byestj9xlr09xWTeExwh6/ybiXMlPrePEdvLZ
         xzPiVMY7lmGPOudU0HAtATER18uFkYHH6NZsjeO/UWFPbs0cMzBDT6smXa51k2MOZjj1
         GTY5ihPVTcZCl/QcUKzuwIbW6ICWnWtCsVFTcxdJBAQdPIYyN1xXxnIWdjQ4o4ntYgyp
         POd2gNs1VwS/LR2GbS9Aug/VOGbcAN9OFKZBQtJvAIpbEnZgJB6SNWm+AuW7aHlNg3J9
         P7aA==
X-Forwarded-Encrypted: i=1; AJvYcCVMAi7E4vtpqBSQ9vpt73Z48BWIeigft7b5RTus1+Sf7qa5wExwpWMhD4na/t5aknL8EErfKHQL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqomk5kaXlIv+IL0gLkPj2X996byS2QtfwgzD/lXDLDD53+liF
	IuK075qLwAQVcF3f8xtdximnwh+tKhac/wFud9V0R2HEvdGIKJaLVXkhW06+1PoUxRjv6A0GfO+
	Q2hmdNnyMIHNsWB7I+Q338GN20qB6Zk4v+vrfANPaD926pPBZ9gk7VUs=
X-Gm-Gg: ASbGncsXvO4hBARXmsdZd3LWFexYmUNZC+fD9VM36QA6eY0Y2OrX72XGh1+n7BtUCSk
	nj70SJqooFl2BwNHxX3287S4udSeJzHV4oECd0+WXD5cvlT4Ha3xVxbt7cdJ+8HauEkZhoQW4Fb
	9xM118x+Kvbiddu6e/+viJ1DrRz9UM4svoJEEkWL9tlcs7fo/or0rpQWL3sR/h+VgbJOdP1LPrc
	mBsQeqzswtMs6Kh0lI/qg+U1s1Ul0+t8l/9j9TAWL78Hzobfboh7ARTA4HJdAifu7oc+QDEdqeJ
	MillZiiA4oey1uwBMavfqSTZfQUroxPnuAYk3jN82G6ZtA11d53HEHuB2w==
X-Received: by 2002:a05:6214:1311:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6f230cbd3b4mr196025366d6.9.1744661493091;
        Mon, 14 Apr 2025 13:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AFC0dXfa/KAZ1s693oa/ZDYO9eQoMkKLPILSuBvxvLvl1Rt7HkM7Cdfsi6cJATP+A6fq6g==
X-Received: by 2002:a05:6214:1311:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6f230cbd3b4mr196025126d6.9.1744661492722;
        Mon, 14 Apr 2025 13:11:32 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea080d5sm88501366d6.89.2025.04.14.13.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:11:30 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8ba51391-d4fc-41e7-8d71-cebc0feb6399@redhat.com>
Date: Mon, 14 Apr 2025 16:11:27 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250414162842.3407796-1-tjmercier@google.com>
 <ysc4oguaisa7s5qvdevxyiqoerhmcvywhvfnmnpryaeookmjzc@667ethp4kp4p>
Content-Language: en-US
In-Reply-To: <ysc4oguaisa7s5qvdevxyiqoerhmcvywhvfnmnpryaeookmjzc@667ethp4kp4p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/25 2:26 PM, Michal Koutný wrote:
> Hello.
>
> On Mon, Apr 14, 2025 at 04:28:41PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
>> Add cgroup v1 parameter parsing to the cpuset filesystem type so that it
>> works like the cgroup filesystem type:
> Nothing against 'cpuset_v2_mode' for the cpuset_fs_type (when it's
> available on cgroup v1) but isn't it too benevolent reusing all of
> cgroup1_fs_parameters? AFAICS, this would allow overriding release agent
> also for cpuset fs hierarchies among other options from
> cgroup1_fs_parameters.
>
> (This would likely end up with a separate .parse_param callback but I
> think that's better than adding so many extra features to cpuset fs.)

I concur. It should be a separate cpuset_fs_parameters() to handle it 
instead of reusing cgroup1_fs_parameters() to allow so many other maybe 
irrelevant cgroup1 parameters.

Cheers,
Longman


