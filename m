Return-Path: <cgroups+bounces-13082-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047ED13DCA
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CBFD3029B91
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F06364046;
	Mon, 12 Jan 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI/roims";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBFTLCh/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB233EAF5
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233756; cv=none; b=fwunPLme3TjhF6dEbhKTH68iBDAOugkbeJf8HiV7KTZn1LOHpWt1Y+2LACvmCUJztJXeGoy0gh6lOYD9kE+Zwi5QFKRjUXIuQd5W/zANW4DsHVjUgigLU1Fsb3tnPgJ7h9Y8ZL2yzwJxEek0wZOC819fQLGa0u++BNCMrEcePbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233756; c=relaxed/simple;
	bh=bC/Qjyk/R/HVGN+FQeWmTeEoWIOx8ZavQXScE/JM/Vc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jkmMn/XFnzgq6aZ0+OX715V+BPVQtjhsR3MwIEzjdk0t+3nxR6HWLjdW32Wey3VNKOmpapY5pb1+24TSGtSo64AKCGSjoJhIyDZHkx8801n1Djt6Mphl6U5OxoKohAPw3zd7wDfpLMzBkAItkKYMsFqW5b060uvWS4q4jwxLazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI/roims; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBFTLCh/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768233754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
	b=PI/roimsEjk8QmGUqVeyENhxVYKU//c5AJQ6Bfwus9Et+pEwdmlHS9J+ZDaaMrUwWGB3Vf
	lNbLRSABKaBM1d/33Kcj/u9m9y31yU3ORicCcsXZy9CAYqWXw4IGIkdr2bkJa4eGvEeWkx
	SJ+SVotz1WPdoNElSqM/4wjr4dvWONc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-M7KW32ClNfua2vIDV9RM7g-1; Mon, 12 Jan 2026 11:02:33 -0500
X-MC-Unique: M7KW32ClNfua2vIDV9RM7g-1
X-Mimecast-MFC-AGG-ID: M7KW32ClNfua2vIDV9RM7g_1768233753
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c1fa4a1c18so1576544385a.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768233752; x=1768838552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
        b=ZBFTLCh/XtkwIPmLxvVyGcnT+UHi5oF9wmgg672lGPDWqpo0BKvpHb+Nz36fuaeAJP
         DzvEhDY3eiuh31G/L33UqQKCIHW2dHffd2BAHA8OyBOgkxDn0eR6CBa5GLwoVNnVmFlj
         FphgiYQqP+w89VgVuGREYNfsuNHE5V4jQuPqvKL2DQaXARbsX+djA23e5mLTO+grh0WT
         ti7zzSXh4GLR6d3/GAQKivYG9+3Ws2OFLYVkEnntMz+vjYFTQuC5DNa24mcbTFPCL2wP
         bt9hEUidzdX5Xc7fYzRQPxAMN05c1ln52whnOVRUWHp4wc0X2Cw3Zcgd4xN0oNKs+/zs
         H7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768233752; x=1768838552;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
        b=hTBGF/PYhvFgN9H/xhfzG5WkJTgxmyAjmE6fvUw9fBKQbCnLuRLSUUl5T9w15PUaRW
         N8c8Feag+ydccd6eo3CSZ6+eD5AZAd2j0I1915ddfh7LqalpJT/eQNwTpxBnft/bwDc0
         sO3S8/kEcg1MycYyfVnQROUTYWXeVUBuRXbK1oyMSyNvMJjpjpkEciEtWA1HlwiLGJbK
         VHBs9dq8MGYmPJWnrIxrhUUGpli/Y94s+o6Jai2l0Xj2GYk7kxsg5/yfI3Z9WKuqdHr6
         EXhxv5LchREF0m5qRJTSJH4bGoTvA3T3R0adoupuRD5LpQYyhBnfriKbV0kp5WEKVXMy
         Hy9A==
X-Forwarded-Encrypted: i=1; AJvYcCW2wFTBvTe2fpaJJ+Pe6SQd76Vt4GOV5u98zDU10omd1vn8QJvz+WR8Yxlu4CXznVyMvG2huPZn@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVM+pGhX8qm6RotSEBv88MK6KvE0hZ9kCMB698xhm0fNCpoGw
	KG/6+eUwfFtEuRYu06gFgiM49yElsNtqqzDqA/IUJJEkbm/RNmhF+TVR6P2qXT47L8PNWOc8Ma4
	VYEb+m0kqB59PopezAxn22fP53eBHKcf574FstyW8n9sLcx/lAa9NbQ7ILCs=
X-Gm-Gg: AY/fxX5/+NohvWM+4iJiLjIefPgCvRmK+B3neX5v34k7OCo20/owTTJdmN2wosp+TCp
	RfDLzF90sAjT+Rv67Lmi6zziNbOF6moAU2NAp8YgnuComzgL4VTOcfW8GxZpoxsflw68JdzJZEz
	Oh7DfTLTlVhz4uHIkvMCHefbnuFh5krL0c1hBxjFxEGgQGLc6nE16C+HL0qE6MaSBK5IGMHX+rk
	hGE6A84pjlILU23oBLD4192mathLlB92HXFf+VRDXyZlBJMwnCGrCRSqXevV1tw41X+BGFMVAFM
	wbvjrQnXy5ZU63IAYL1KuUNImdq7rU/ZYpsrP5CmMsTRQedhakPxyaPqZ5AxC0YUtyORGxGdmt2
	fBr0oIvn1ymQwIS7+ENNJmfFTRmHc/uL26YZ5QLjeWDu0RGaIZq/psi5L
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id af79cd13be357-8c3893dca80mr2449096285a.45.1768233751989;
        Mon, 12 Jan 2026 08:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJi2/0HC1+IC4PuaBeIdB3G5w2rUk7KP+T2Nhpx9j47KDX3VY5aFRtmJJXjg0pMKFLyFlL1g==
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id af79cd13be357-8c3893dca80mr2449083785a.45.1768233751123;
        Mon, 12 Jan 2026 08:02:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6441sm1556650385a.7.2026.01.12.08.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:02:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <86b578f3-70f5-4a72-9371-e35478ec1c01@redhat.com>
Date: Mon, 12 Jan 2026 11:02:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Chen Ridong <chenridong@huawei.com>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
 <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
 <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Content-Language: en-US
In-Reply-To: <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 10:15 AM, Waiman Long wrote:
> On 1/12/26 10:08 AM, Michal Koutný wrote:
>> On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long 
>> <llong@redhat.com> wrote:
>>> Sorry, I might have missed this comment of yours. The
>>> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted 
>>> to its
>>> children as exclusive CPUs. The cgroup root is an implicit partition 
>>> root
>>> where all its CPUs can be granted to its children whether they are 
>>> online or
>>> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as 
>>> well as
>>> exclusive CPUs that have been passed down to existing descendant 
>>> partition
>>> roots so it may differ from the implicit "cpuset.cpus.exclusive".
>> Howewer, there's no "cpuset.cpus" configurable nor visible on the root
>> cgroup. So possibly drop this hunk altogether for simplicity?
>
> Ah, you are right. I thought there was a read-only copy in cgroup 
> root. Will correct that.
>
Below is the doc diff between v4 and v5:

diff --git a/Documentation/admin-guide/cgroup-v2.rst 
b/Documentation/admin-guide/cgroup-v2.rst
index a3446db96cea..28613c0e1c90 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2641,9 +2641,10 @@ Cpuset Interface Files

      The root cgroup is always a partition root and its state cannot
      be changed.  All other non-root cgroups start out as "member".
-    Even though the "cpuset.cpus.exclusive*" control files are not
-    present in the root cgroup, they are implicitly the same as
-    "cpuset.cpus".
+    Even though the "cpuset.cpus.exclusive*" and "cpuset.cpus"
+    control files are not present in the root cgroup, they are
+    implicitly the same as the "/sys/devices/system/cpu/possible"
+    sysfs file.

      When set to "root", the current cgroup is the root of a new
      partition or scheduling domain.  The set of exclusive CPUs is

Cheers,
Longman


