Return-Path: <cgroups+bounces-6225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E35A154AB
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA783A709C
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167719CC3A;
	Fri, 17 Jan 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mbwWs8y7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0751335BA
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132472; cv=none; b=VQt4JBsMsXEeXTedTMxfyax8LXLnMY0VaRT2xDbXEE2iPwFdVc/ZkBTw7H7Ywx9izgkJQHcTR3/Rcl7bkpvMgM2Gq+5V8E87NJqirUc0qHjlbDhHpzUJRb7GzWLG4lLuxS7tfDd4IMdOpSpYxKzgKfbNj7sV1W23hHLK3rnVhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132472; c=relaxed/simple;
	bh=LekiLxjmEZu6e0m+oSb8Ke+0BjTVtML2AjG7Ue6w1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTf025tLJyL4QhYmgkcLXGCOvI75q5JxmdckE6XlMPO0GYL7uyNdiacFTQ3lwoDlhn7LHZtwqsL2nIN/qD3qiZXGxxEsxp3bcrHY6CFNPYaTDst6t+qS1YZZI5WmMK//T/imo0L7Oqpsjp2wXNpz4iveC806f2bBNeA1g+zUQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mbwWs8y7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso21447166d6.0
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737132469; x=1737737269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALV5l/odctAX4u/DDnncfiVwNjPi9uf3gn37R/WtIws=;
        b=mbwWs8y7BeGELb1nmXASH2VN+KxgwimwV6+VqlEe+rb0khrJ7d8bKOFB8yu4vi1otP
         j9H7ydlsbHhZCscrI3gV/fSN2p5kfK2RkSU9kcH85EI6FpQ1vjcMh7KSDQgLrSCiAzYa
         /yFhvcMXkvNVzqASwerAVecv0Rn/Kbp/1Pz9aQQD7vM3aRuJ27tSZ7oX1YrtjvaErxZB
         fKXCBrAqb30Ykzdhdj2ZGmn0uFdYL7qPRILhPsCvq7ZIs2tkaBMeX+u7pkmQ8miqZejO
         aFtmVtSRrFpxXsPVkmNVPeg8eY4R77Q3pzOv/DKkGlsO8yymOfZHnYk8+49NtskwYz1M
         avEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132469; x=1737737269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALV5l/odctAX4u/DDnncfiVwNjPi9uf3gn37R/WtIws=;
        b=qpAlc5bgRjlZAIdj055x4q9RZapHwJu5O4QK6hjd1IPxnix38GNugpF8spS6t6Q2Kp
         w99MstzgqVO/qJnqHmctuAoCgPF7tpUpxQE4DnDz/AU+ckhgFuVgwY+okXGrAmnZPoQ3
         gLtQ6ECwE0WWCJ528U/2daO50zub0EKYEJRQOWprtKFM0HuIaR8yMeol9SDo/NaDmbzw
         fyfZeq4Y0lNRxgau8cEip6Q5Iw8gPBirI8XZQAuJkF56P/oW5Rg+zjWXfbZQl9eNXrlh
         k8aJHmQXoAiir5nFQuRFj9ANaBI/7Kho+8ZGnnKZtao0hNnLVZoN86EBH9mc/Rs6lAeP
         GH+g==
X-Forwarded-Encrypted: i=1; AJvYcCVR35iTwMqypubI/kBwWnznrjKQxryOCyncnXiaSQcnLScWVsRfwB82gcit6/GE/xHQ7K4iq8Qj@vger.kernel.org
X-Gm-Message-State: AOJu0YxnD6TkmcQ2Akp5T4sMj3o9acXB2Q17q+sL3S60i0Qew57nM9g2
	o47yjo2fC8BX8e0cfape7LAY9MN0HDDcEXunoskXLzhiMbz9qdYTKFDlh13879vRqV2h8YrZMP+
	t
X-Gm-Gg: ASbGncubnK6+/WoORd+QIzOqZGqR/vYvuTvSiR1f/RR46IxPjqC2Ee/RvP3R5rDyT6H
	Fe1m3OpJ3jCf6vxrL8B581Cj9RbtUeW1WrzN7kMefUoX58WNHQJ0KafpeJC3kKgHpsJPiiPTns5
	bj/ABMuKzRuqwEg2vHZChaUqrVGinDfc+NJw5GFR+m7deUN3ImpuXRXQaDMssZ71i09M8TjQk0d
	clT18mki/98EOgYRBhAnKxpSd8Pb2NgRdtV5Nj3dc8GT1bRNuMURJI=
X-Google-Smtp-Source: AGHT+IGJD22IumK4sgXeQYpyReO0k61FPPlVycvnYk8ngibV4lTzbMH3JRKUWQsEY2VfnGaf5KWdIw==
X-Received: by 2002:a05:6214:400f:b0:6df:97ed:54d6 with SMTP id 6a1803df08f44-6e1b2180604mr62615746d6.21.1737132468860;
        Fri, 17 Jan 2025 08:47:48 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e1afc117a2sm12960046d6.40.2025.01.17.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:47:48 -0800 (PST)
Date: Fri, 17 Jan 2025 11:47:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 2/5] memcg: call the free function when
 allocation of pn fails
Message-ID: <20250117164748.GD182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117014645.1673127-3-chenridong@huaweicloud.com>

On Fri, Jan 17, 2025 at 01:46:42AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'free_mem_cgroup_per_node_info' function is used to free
> the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
> free_mem_cgroup_per_node_info function will be much clearer.
> Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
> fails, to free 'pn' as a whole, which makes the code more cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

