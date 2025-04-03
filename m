Return-Path: <cgroups+bounces-7331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D5A7A44B
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 15:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42AF189A3B3
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9324BC09;
	Thu,  3 Apr 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvS3dYfD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFEE15CD78
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688130; cv=none; b=eIpESGqTLDW0ymxJBAIVlGGeT65gAfMk0s9EsgaOKxYbiS90mBDYoOCWecBzzQPpQqeJc8NWpHnFznnah6MH8EEOtvSotU2YmeCHvmnMDt7L3ap3HVnlM4QoB8TFstqJl41ChN1sguJw9S9L92+uL7zyNtizG/N1spBc4Ai3ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688130; c=relaxed/simple;
	bh=X8K2hZQqJMCGMpB1ml3pgOIG+WSAB71YixBcihVOC/4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PCGju+nr/+jNSnNarAUIeDONXMXe9P2QduHdI3IKXZffDwLIrzQXop1RgP1v7S8HM9rx8doCOdkoqsiwJdAOm+Mkv9HRFMdhYmu//3AvXP2MleI4tdAMC3MADZ1fRQx+ASNyBX8TrvPPXHGO2Wb/j2AVs/EwizfQQTtCq74kkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvS3dYfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lyWZ8gblDVHe120rUXUjARVSAokRrQ5lvfAATMT9n4=;
	b=cvS3dYfDK0c42IgU3FMXxTaMak5EGaz9n+qv45xMK4XS3fHcGeyonQnJujlEdLaxIMNoBa
	8eE5JVnhrStOYD3PwsizbNBIp2zJaeGX/YB/5sI6udX/npk7I/XzFxzXwqNEvuQ5vwNdt9
	CoES3tcZ882cyghTUfUdiXBFHTijM18=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Iw6FePcyNFmvCd0n_vuRWw-1; Thu, 03 Apr 2025 09:48:47 -0400
X-MC-Unique: Iw6FePcyNFmvCd0n_vuRWw-1
X-Mimecast-MFC-AGG-ID: Iw6FePcyNFmvCd0n_vuRWw_1743688126
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4769273691dso15355161cf.1
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 06:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688126; x=1744292926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lyWZ8gblDVHe120rUXUjARVSAokRrQ5lvfAATMT9n4=;
        b=vLMl5x7uMMsehDZnWGEYw6ZMpHuCmfue8BnvbzoC9s4U9XHeQAGhIXAiqmnijlWU6E
         C6nNd+bSHNaCO8KgmsQBoSdIv8mSls5kVb5oP4T361w9HTEBki4mNyoQBXeAXW1H6kQl
         7Wq/8PcOLsc0Kth/amkDyBsqlG7iisOKMAB/f3E9ojDgRPmOz8SfLE9ck7G8k1TZid4M
         P8orguMafzQ8ZnMlxoBn4JhtYCByHoyqhlI01B+4kVm7rdC079RabSc8KQTL7CLfX/iu
         RAhe07AYC5o6/210E2OVGt5A8O7LYaSi5r0zuOgkbh+2IOPo9ZChfnTQyphe5QxoMMNF
         4z9g==
X-Forwarded-Encrypted: i=1; AJvYcCX5JlSKRDdbsM6tCw2MkSRPRv+0j49g9AS0P8NjHCnScRC0e7iufziivxpYdOWX/26LGrV+3atZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOnv40L6AbhNJvZsrdIUiBaEpl2G5qMvb/aklQIPuP7WDuYEd
	PpmrOU6UaIz4pZ3/o9qs21l1TicUJZJ8np87RfhH71rEbk/i/u7/AjHj9JqhTGRknw7dJ8dgXc1
	K2ak+nEtXu7YZ7G9lp0GhsvJeOLR9sSJKRu45PO3YlNc0VCcp35+beMY=
X-Gm-Gg: ASbGnctXOXsyNe8R5n1G3CUwL1IcSdYJW6xkp5gykxM7aMNWdGLlF+h/+YCCsa2usUq
	KUlXkXT2uuEmc7+tt3dZZy6LbynNikm1CGKOyUo79rqkYhDh2ncYfP0/KsJXI5rJ2ot9KuJLmmv
	Vv92i/DdrJ8Rq/DCf/iAhbOtT5/5+X9UKrVaYDvzoVz5V2S3GpgXlrGHc2Ep9azZlWHOAcmbo7o
	rv4atmqJb20QUwgVMzx4Qw6tvw3DNZLWh5rN7L7zU3nrJKly1OykyBq5zI8sghhTGH2R2zHQ9kl
	vXxePVLf79Wh5qn0qPc7HeK8adyCbV3Z+rEfrq/M/xTY4PKNUkSMy/HfbhY8+g==
X-Received: by 2002:ac8:7d84:0:b0:476:98d6:141c with SMTP id d75a77b69052e-477e4b66bedmr383982031cf.18.1743688126643;
        Thu, 03 Apr 2025 06:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo7x51vzTVDAQ2P95L9od9uzm0Cwj9FDry+VsenXXfp21aleo/hYZIXBJiuOhWfUblZcxwtQ==
X-Received: by 2002:ac8:7d84:0:b0:476:98d6:141c with SMTP id d75a77b69052e-477e4b66bedmr383981751cf.18.1743688126419;
        Thu, 03 Apr 2025 06:48:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088346sm7967391cf.41.2025.04.03.06.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:48:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2d1b9c9e-a63b-4385-b706-0eee73688343@redhat.com>
Date: Thu, 3 Apr 2025 09:48:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-6-longman@redhat.com>
 <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
Content-Language: en-US
In-Reply-To: <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/25 9:33 AM, Michal Koutný wrote:
> On Sun, Mar 30, 2025 at 05:52:43PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Currently, we don't allow the creation of a remote partition underneath
>> another local or remote partition. However, it is currently possible to
>> create a new local partition with an existing remote partition underneath
>> it if top_cpuset is the parent. However, the current cpuset code does
>> not set the effective exclusive CPUs correctly to account for those
>> that are taken by the remote partition.
> That sounds like
> Fixes: 181c8e091aae1 ("cgroup/cpuset: Introduce remote partition")
>
> (but it's merge, so next time :-)

Commit ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag") 
is actually the first commit that introduces the concept of cpuset 
partition which is basically the local partition that I am referring to 
now. It is that commit that did the  partition cleanup in 
cpuset_css_offline() which is now being moved to the new 
cpuset_css_killed() callback function.

Thanks,
Longman



