Return-Path: <cgroups+bounces-11892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493BBC547CF
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 21:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3F63B3423
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06052D5920;
	Wed, 12 Nov 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI2Z2PnG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsLzctYT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B272D321A
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980045; cv=none; b=dv1ausIKA/6y9NAGDkkHC8zObvHqRlCh1mpDiCSbi6gtnUkhB1z97TinkbpnytAoqXa5NxfEH0kIiFhLr/KijsZE+wcvMR1DUzLfXNFtFWgvuiVTVIlxabpkorYXbDi0Bkzz0SIxXVvMa2uDkk80JEOVLzynD7RlGahN/r2luyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980045; c=relaxed/simple;
	bh=gxTTxN3L7EVSOLksgiMzU/dnG2DI65ToYH4gH8GtPZo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FmnyWmNK99ZY+X0YqGor2CUyP7R9kvp3kPJoamPLMA0+8W3a90S23ddW+pRqGMjIC6eP6tALqDwEiG7pSlqMV5rEx9jcb3a4f/o5vvImuTeKOGwx6z0Trc8upPE57Sb930AdPIIOGn8T5ScfAsF0jgKDjYitaS/sCB5l6BI6xUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OI2Z2PnG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsLzctYT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762980042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
	b=OI2Z2PnGDPRkch0cuQltBFLRvx6PsqwylV1a4cxU9A7HwsHbdeLOksacDB4Muh6MCbgq4M
	/2Zo7Z3WRyC0L6M8t6h+kevQuTime9UUycnMltY3JzXoOGDfpyJRTDreb8KrX1+E57Aoa/
	7Ab4k7w/z3H4AZZ7iqEx4nizXWs92Mk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-1-KkDtysO0iSVyK8jhC_Kg-1; Wed, 12 Nov 2025 15:40:41 -0500
X-MC-Unique: 1-KkDtysO0iSVyK8jhC_Kg-1
X-Mimecast-MFC-AGG-ID: 1-KkDtysO0iSVyK8jhC_Kg_1762980041
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a9ec099b5cso36014185a.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 12:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762980041; x=1763584841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
        b=SsLzctYTA0BU1t5Y4G0Re1ozeVJAbWrUp7BS2Aa9CBYcx5uTdhHpuIRLOceCi6OeM6
         z33sIaSte+mFW6MxUGwM1tvKBP0YqV8XHYfrOc4bSTnmHj8DHSTQ1H/m3muvAW0gvcal
         F3Pvlnxvx/hWDcxfnqGHxBRstWbzGY1urW3h9jRf47N7FeC9CF6o+xc8lQD3AHaXlxes
         asAielNXP+Kynb7zC0iEGaA3hKDPFXWye7mo1wwz8aJ6kqhhEUU4u1eFJLozz8nR+3eb
         kVjEOaHCBIchcXPlDLAmy+JTDeIwb7u6IqZft+IQGiwIE8OKMxlErvKqM3tNc7IislaP
         sxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980041; x=1763584841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
        b=S+RY2dOuW/8qnCvo+CKTHaJ69KGEIFjJB3z8UkUS8/ODb4AovwUIE9z15rKX6Glvim
         qDYKB961gq1W+YCEP3Sm0D7q1NBrN2wQUb+X8AWtt6z+64Chvvsw3JjVz1Gff6xy0eDA
         WM9293EEO3S533FYdTNzVApXt8ip/PHk0fFyuu7MRMLtR0XmP1pZZRsARXF6RLrtXdRw
         INojUe+5vKIqCAHiO18mbnE+3ySqZASxDmjctSq6buvzUIr2YLNZWrkkog3gL4kmX4PN
         XTnEkC5kS3sqIPuZZpAyXT4p3KLPfMAVIoQgmKmqlIsjUzJshXbAGt+2CfN/bcIrc/qx
         DpQA==
X-Gm-Message-State: AOJu0Yz3SLVq7GHOipHZLn2lnVglkXK6hD7LOBqnguMDVxf6riJIjHi1
	iwtc0teG2itRK/SOLfgnW1i/J+Zl0hNfnxD241pkuiziN9etXRmC0NA2KHNC+lJshLK2TA2Xceh
	Xffhlk5FtqpeW5piepwEDH/LJ2FV6i9QNNqHD4YG4c5+DXhV3rapmH9AEi7I=
X-Gm-Gg: ASbGncs6FswZeNPsulMBlnSDLv9BQAwqf5jrRjdhHIbxVMgVwwU6oKWpS4KE1+Y0Esh
	RTBDvqn/kJ51lzorbLoUDKii2ZvD33BELqgSmGstcgL020lOoX3oPXkqK9L8ytSjzBY6ek85GFh
	VgvjX1/fhcgGOazGlTLNtcTB2r6TxJWO7R6U7Xm4nTrIp6pCBYOJxtz868K4CTHjotZC+0i7aP0
	M1GVT2rGQRu87IMjd48eUgDtwkNkpFTq92hHdGjkus9N50u6P/vx7jD/7jWA5fIxVG9SrMPDsiI
	4yXoXRoI4XbRyDwS4YxOI39GQUGYX7+qpJCK101ye/XwekpE1AeeaQbxdO5UsMq7qyN+I3IDiO9
	QycOUq6S0fmBCcqNlAVvMoTye0hEuVM56WNV6Rdu5Or3VJg==
X-Received: by 2002:a05:620a:4153:b0:89f:764b:a4aa with SMTP id af79cd13be357-8b29b76cb4fmr601023985a.18.1762980040920;
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESa0cF9mOhl/LFwYPn0m7Z03bsgMvByXtJS4tECV4yQpiTHl+tQlSjtmEDSnxUdhU37GsGmw==
X-Received: by 2002:a05:620a:4153:b0:89f:764b:a4aa with SMTP id af79cd13be357-8b29b76cb4fmr601020485a.18.1762980040481;
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa22f51sm257239585a.51.2025.11.12.12.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <95f36634-d4d7-4d47-b949-e34b6bb0cce2@redhat.com>
Date: Wed, 12 Nov 2025 15:40:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/22] cpuset: introduce partition_enable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Add partition_enable() to consolidate updates to key cpuset structures
> during partition enablement, including:
> - remote_sibling
> - effective_xcpus
> - partition_root_state
> - prs_err
>
> Key operations performed:
> - Invokes partition_xcpus_add() to assign exclusive CPUs
> - Maintains remote partition sibling links
> - Syncs the effective_xcpus mask
> - Updates partition_root_state and prs_err
> - Triggers scheduler domain rebuilds
> - Sends partition change notifications

Could you add a leading space before '-' so that the itemized lists 
won't look like part of a diff file?

Cheers,
Longman



