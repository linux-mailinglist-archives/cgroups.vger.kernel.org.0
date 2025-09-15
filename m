Return-Path: <cgroups+bounces-10116-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C838CB584D7
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9FD4C3823
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F6285C8B;
	Mon, 15 Sep 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6E+mqEd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DA27AC2F
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961776; cv=none; b=QXDqHfxVpVOKBymzRvvspvQx5tPQr0+T33JaijTnH6XjoEPpp3fmCQ+B1a6ZhlTkgz44M9DgpEIsj9alBXWKpotxpLeO9PFRxogx+7vGwU6V0uL3VpnEY3bL8pGzIvD2Ac5R4//92+pBFsil+AGuQoeSVdrDSxL4+Yp4s1AdWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961776; c=relaxed/simple;
	bh=ssLXklQa2sv4me1/Pc3Ed3Wkuo9uZMnk7M50G7qvATw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DFT414t2mQOugGGRc3wPmnRWk6yvq7K1aa3oGMXBJZvQoNTuJBtk1nRew/awRGEHzviOBHpUgioUy9x5K9ou6IzTeFPrhr6IIrI43LnOmu1gfo89C0uzYee0fNpa5xfyRTxupUKigKBB9UnG8ZI1fIQA2epHAaiMqncVhiG4Xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6E+mqEd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJQiuuXM1OJgX/OTMX2LaubLVboY/ge/7we+Q6Xewa8=;
	b=B6E+mqEdegx2aiV5wDHKYWRODMA/dRlW3hHga5vEur8iUENgQVaERYPol0BazrxebDDTkO
	pRGBJRTSyzXqSTNEOFCp+fyL/UMdoqJnL2ow0koylJairO+SGATcfLvZRGZAthHR1RIgja
	hqLLL/KDGT4yhI32Wy9N08c0jPcUQ9w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ThucCRC9OaGCaeA2UlJWEg-1; Mon, 15 Sep 2025 14:42:52 -0400
X-MC-Unique: ThucCRC9OaGCaeA2UlJWEg-1
X-Mimecast-MFC-AGG-ID: ThucCRC9OaGCaeA2UlJWEg_1757961772
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8217df6d44cso912927685a.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961772; x=1758566572;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJQiuuXM1OJgX/OTMX2LaubLVboY/ge/7we+Q6Xewa8=;
        b=rpnMlKqC183et0Co+oMc81RPvzCgRPyldb/4OF6Yha+WaBMdK6wT2O3m8WycqItvcf
         CgD8Bf6cmm1C+4EwkpGGcc57Hpj4sVg1tPdNegCqhhMhvSwMztaJ4RgSFR3/JIDsWeW/
         KZRyNCMOpcETscoHtl/l6y33Yj5+dWfvZVGSLpKb8CsrwfzHeTc7Jq2d8eDStK/XbdrE
         1Q5WBVRDwunAX9rycgUGsJ8FKkd+m9TEz7Qnp6CJFoN1gKM8Uxli8gwj08QOu+YSuWlZ
         fVIyT/4R4tzRkIHzIcygSR9sNKDqRolFzOOYEweVKd1jzgau5yGGGZRfqJEOl+AjvrPB
         Ym5A==
X-Gm-Message-State: AOJu0YzslkOo1CBodLqXPJ8fu8NqrqlDp/j2RFdaMQ6JdCuhMXL4+Sbo
	CocIA94HAhp09Bmr+4+PWN1Z2rVJuPE4X2JvcAbwW0CALfFx3/S5umLOAYbu2zts6lIU1RBId84
	D8zCN10UKq5xB442faP1+XjpQzRWEnEsgCOTlKBGIik8Txhv0y99PRVjVkjU=
X-Gm-Gg: ASbGnct8DE8/AxdrFICrsIClD8WVdjdRaFPu7ZVtBxOr+Er13tnIIztamOUzh2FIsqK
	5hPwBXLzhvOMa5avfD5jrPbfO702+9CDhE+Q4LYKiGIi4+F1Jj80BbUY2OKwbBOqgPzQuqC4BBa
	DQXPQlPxx6F1shYorsUbi17TrYutDbD3stbzMazS6uNckgJXZpR+bywAOPv4vHpDnDSuSCXPGbG
	oGUklbIU/biVSOAcPFnbOuUbcKYZRf/L8ukc34O2wGxx+/EBfwSxKSH0lkhnq/5SugGaWQRpBY0
	u1nUyyO+BOxhE47Ql4VDDeprmZaIs3qbmbSWPkih2Jg3TAvanxPDXuN7yl1S2hidjyAffV+SM0R
	tEC09GYogkw==
X-Received: by 2002:a05:620a:4626:b0:82a:fb2c:ae06 with SMTP id af79cd13be357-82afb2cb3abmr247630985a.1.1757961772137;
        Mon, 15 Sep 2025 11:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErSGDrCSZKUqkKtEwG0Zms+sT/vdQKZh07pc2eUIfZ6TUqInY9rvaVXqZeLtUlqPGmtBAGJA==
X-Received: by 2002:a05:620a:4626:b0:82a:fb2c:ae06 with SMTP id af79cd13be357-82afb2cb3abmr247628285a.1.1757961771666;
        Mon, 15 Sep 2025 11:42:51 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974cf21sm849092285a.22.2025.09.15.11.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:42:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7085a2a8-0f03-4222-9ba8-9281e25d8daf@redhat.com>
Date: Mon, 15 Sep 2025 14:42:50 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 06/11] cpuset: introduce cpus_excl_conflict
 and mems_excl_conflict helpers
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
> functions to improve code readability and maintainability. The exclusive
> conflict checking follows these rules:
>
> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>     not have any overlap.
> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>     must not intersect.

The term "non-exclusive" is somewhat confusing. I suppose you mean that 
the exclusive flag isn't set. However, exclusive flag is a cpuset v1 
only feature and cpus.exclusive is a v2 only feature. They will not 
coexist. You may need to update the wording.

After you fix that, you can add

Reveiwed-by: Waiman Long <longman@redhat.com>


