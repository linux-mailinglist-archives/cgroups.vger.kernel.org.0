Return-Path: <cgroups+bounces-11876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A3C53D84
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 19:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17B9B343971
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D860348867;
	Wed, 12 Nov 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCuHR/3q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvBBqqqy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A03335073
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970722; cv=none; b=VrpI49cDDMzLQfkYAcSxkpZsHgA58VnaGvrAEnC/gKxH0KE7Uu6MV5v5IxNr0AQfZedUxytqdqD51DDgIKRn7UsuqhBNM3+jiZDlwWStRZkyMroMNk2DI0Os/Sfq4mx299877ZEalBjbXdTyIdqrOegHvx4jLgh4W+RgWX3zVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970722; c=relaxed/simple;
	bh=ko5BbGl6a9fQFlBxeoKvlk91k6qFsjA2qTndHaSt7YE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bD4i4GgrcOZ+DyMJ3As4e4/h6NSs0R7wU/Ov9p0u4T0e3hlWDl9L6pn+HlF3Hyf6dATczh0P4MoSyHzAxwayKIimlk7OEWCN5YtP7GAbhgMYookWxL43FUVAFnGz/0FT6Je/QSKYKy0ID3RYTCTT0qgy5PQElPpp/oUZwN7BPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCuHR/3q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvBBqqqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762970719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
	b=FCuHR/3qXGnLB9pvrp2X3NsKGrGybR8DhnSIuJTocE09BRm+1vZ3SuNUdBfnt1Xy9nsOSL
	p2CMWLCAG24ZRIP0J1hBc6GOnf25gXN0+/ApUFL0Kv3vR/DJ78vO6RXQGT2ylefvox5uZD
	EanRBSdSCxF+JFl6ujNNDocJiDsFniI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-JbYErc-nNKGm4N2SYvcXyA-1; Wed, 12 Nov 2025 13:05:18 -0500
X-MC-Unique: JbYErc-nNKGm4N2SYvcXyA-1
X-Mimecast-MFC-AGG-ID: JbYErc-nNKGm4N2SYvcXyA_1762970718
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-882529130acso28966506d6.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762970718; x=1763575518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=fvBBqqqyTlsxOIpJ9UPap7LmW1Xe5fW9YUJV3oCBJ1KX1CFIaX5xqLNBDGrE7gge5Y
         O23qi8y+k/5Okr59fUf/XJ/xTSlxUh2UsmSta2Yzr8xtp33E0JCsZ3Wqjk4402bP3pQa
         N+dmz4M8zr/G0Y2E56IAN9pe3sJkpxUlNJ7hYJIpXEot8BZ6eqO+cfKWL+T3TWNneOwZ
         MaMEXMvUkwX6xO4PPRDYphpIJB7/+2tZhjfJ/bt1IIGUpN2TE4da2+m8Q3WHXkrgoAyZ
         OESEdmlcK0rpnVjrCSdbYp+Rax+vRgEbFheMfR/h1HpG9m3Z9n+jZR3RKTPKhBcxUQOW
         PidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970718; x=1763575518;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=MF2eORaoqs5dUKv3F00OGd/j00WupkW1pJfa+dzF1+6Rm+SVyvM3gLkbTQW7YUCxae
         oHJAT+BqDCb572H+vRobb85zscXEP+0LvRr1sXWBy9DhDNq6M1Nf6/oTfRw7toR4kzb6
         iqhKa0R2Y5yR6pjOWy0WBEO57ch7C3LsoCetagTpjW9fTVLCbwvvkj8V8Wi0UdL5qeiE
         4nNXUU8VBOJxFkzoAgCos0VnYHw/nidjhH/bgkYTuCPt2X4++QNAEc8FpyIUIxqivSDg
         rSlzJ6GbL9VNbk7NSNcrUlV2IuxF2ewHyGU9WapjO8ZNAwQbby/Z0D/B4R/qIbLMzG0D
         Ri6w==
X-Forwarded-Encrypted: i=1; AJvYcCUIY4PX+lxMZgoFeaqki7uOX+a/hZRL6gxaHW1TAOhIz9EldXl5tV4BvRKedoHGPOX9dEPoDi5A@vger.kernel.org
X-Gm-Message-State: AOJu0YylmkMNVec3ScTXnprUZy2dqAuBoAZVDgpdDH16NCSygc30ckCc
	Pck9dPxIhP5RDGAPn0DKfK7WFJb/O4/sWzkWyhaTnv0sj3epdYHINedZ3OlHgc8lEKjEDMgUoHr
	qDS6GoiAZCMKFTFaP+Au0sk9tjM7g+tsGHrcdmMaNNJhf7ysWHAxF5LTmOPE=
X-Gm-Gg: ASbGnctj4LGtXhpCYoJKYzsBYdG8FuUtwFcNIjGDEuW4Xe4j0I7qfZBBKuMI3gsoAsY
	FgVX/e5j6umJvB7uoJUUV8RqOO0nGVz9OJQ0TSaRhKxDNbXwmVmIGPgFc0zmRtSBRbW9kR1fC2d
	DeSH1M4gF6Mq36wjqUx+mEULvpAE8SFivREPHHArrTQ+qB2uO38zZ/zpdvNuGQUfMxxbMB9UJ/e
	hIaips5uVw9guikkAb9Z92OJ0s16qXN1e7AfvwzCzpSOSsNG+WCfI5egFRq33kU8mpBWB89OjZt
	T44qcD1ohOQBcMc2kZRlViLLDn6uhLB/idpmiwy+FNu4/Nx2i74SWumPQAVB5xsh+paTx59Motw
	fq0Eoz0AvdkmuU59P6+jPnle362Mrb3mldh9HBsz7Qh3pSg==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688826d6.39.1762970717969;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4IiIw+N1Z2Q8t2UVNI42KNkJKyBdYBTSzcbCJ42RBQAZsdIZ+JdFm9V5TA71Qksd6vDNtIw==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688206d6.39.1762970717419;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b293a6sm95893676d6.37.2025.11.12.10.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:05:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <85f438b2-5131-4794-bb2d-09ca611fb246@redhat.com>
Date: Wed, 12 Nov 2025 13:05:15 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 4:46 AM, Sun Shaojie wrote:
> Hi Ridong,
>
> Thank you for your response.
>
>  From your reply "in case 1, A1 can also be converted to a partition," I
> realize there might be a misunderstanding. The scenario I'm addressing
> involves two sibling cgroups where one is an effective partition root and
> the other is not, and both have empty cpuset.cpus.exclusive. Let me
> explain the intention behind case 1 in detail, which will also illustrate
> why this has negative impacts on our product.
>
> In case 1, after #3 completes, A1 is already a valid partition root - this
> is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5,
> A1 changes from "root" to "root invalid". But A1 becoming "root invalid"
> could be unnecessary because having A1 remain as "root" might be more
> acceptable. Here's the analysis:
>
> As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of
> CPUs to be granted, however, is subjected to constraints imposed by its
> parent and can differ from the requested CPUs". This means that although
> we're requesting CPUs 0-3 for B1, we can accept that the actual available
> CPUs in B1 might not be 0-3.
>
> Based on this characteristic, in our product's implementation for case 1,
> before writing to B1's cpuset.cpus in #5, we check B1's parent
> cpuset.cpus.effective and know that the CPUs available for B1 don't include
> 0-1 (since 0-1 are exclusively used by A1). However, we still want to set
> B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in
> the future, B1 can use them without affecting the normal operation of other
> cgroups.
>
> The reality is that because B1's requested cpuset.cpus (0-3) conflicts with
> A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's
> partition root. So why must the current rule sacrifice A1's validity to
> accommodate B1's CPU request? In this situation, B1 can clearly use 2-3
> while A1 exclusively uses 0-1 - they don't need to conflict.
>
> This patch narrows the exclusivity conflict check scope to only between
> partitions. Moreover, user-specified CPUs (including cpuset.cpus and
> cpuset.cpus.exclusive) only have true exclusive meaning within effective
> partitions. So why should the current rule perform exclusivity conflict
> checks between an exclusive partition and a non-exclusive member? This is
> clearly unnecessary.

As I have said in the other thread, v2 exclusive cpuset checking follows 
the v1 rule. However, the behavior of setting cpuset.cpus differs 
between v1 and v2. In v1, setting cpuset.cpus can fail if there is some 
conflict. In v2, users are allow to set whatever value they want without 
failure, but the effective CPUs granted will be subjected to constraints 
and differ from cpuset.cpus. So in that sense, I think it makes sense to 
relax the exclusive cpuset check for v2, but we still need to keep the 
current v1 behavior. Please update your patch to do that.

Cheers,
Longman


