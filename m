Return-Path: <cgroups+bounces-12002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4694C61685
	for <lists+cgroups@lfdr.de>; Sun, 16 Nov 2025 15:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B273B3A23
	for <lists+cgroups@lfdr.de>; Sun, 16 Nov 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28F2DA76F;
	Sun, 16 Nov 2025 14:09:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51027FB1F;
	Sun, 16 Nov 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763302155; cv=none; b=jl+cCIiijD07SgZDWVHHUyPiD3UiEunmF/k0e7utzuzaFUY9FoXggzI/UOhkEt+6VT1GwcLmCWZ5T819pcePWJCRSd4/Vj/31hkG4DJlaAmB/5Ux0mYDghG/W+KtjpG8vdHq0AxWnB9qGMbdM8sHIdG9/PuCKUUYgepBw9NaxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763302155; c=relaxed/simple;
	bh=p6Reot7hyCJQFfhq8+TZl3U3rHCPdND8zBdateodSKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhQw+z27WGfHaEsqCOap3hMuLpzrdVsGc1A0USv/VqwsQJCwdXa1qQepeQx5kAXMbL5GFSiR9AWxROzIkQV1uu6Bdgt45C4Tmyic4uw2WoP9RfZMqAyETQxoifCltIOIab/125LbPztW7nmThePLmj6VVbvpPSNs6EdC3+aTg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9b5d0aac2f511f0a38c85956e01ac42-20251116
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c484484d-5a33-4807-a865-6678e0874e81,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:c484484d-5a33-4807-a865-6678e0874e81,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:baa3856a0070c99d7e13aa0cb4d65647,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:16,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil
	,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9b5d0aac2f511f0a38c85956e01ac42-20251116
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1756427652; Sun, 16 Nov 2025 22:08:55 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mkoutny@suse.com,
	tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Sun, 16 Nov 2025 22:08:32 +0800
Message-Id: <20251116140832.954477-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251115093140.1121329-1-chenridong@huaweicloud.com>
References: <20251115093140.1121329-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/11/15 15:41, Chen Ridong wrote:
>> Our product need ensure the following behavior: in cgroup-v2, user 
>> modifications to one cpuset should not affect the partition state of its 
>> sibling cpusets. This is justified and meaningful, as it aligns with the 
>> isolation characteristics of cgroups.
>> 
>
>This is ideal in theory, but I don’t think it’s practical in reality.
>
>> This can be divided into two scenarios:
>> Scenario 1: Only one of A1 and B1 is "root".
>> Scenario 2: Both A1 and B1 are "root".
>> 
>> We plan to implement Scenario 1 first. This is the goal of patch v2.
>> However, patch v2 is flawed because it does not strictly adhere to the 
>> following existing rule.
>> 
>> However, it is worth noting that the current cgroup v2 implementation does 
>> not strictly adhere to the following rule either (which is also an 
>> objective for patch v3 to address).
>> 
>> Rule 1: "cpuset.cpus" cannot be a subset of a sibling's "cpuset.cpus.exclusive".
>> 
>> Using your example to illustrate.
>>  Step (refer to the steps in the table below）
>>  #1> mkdir -p A1                           
>>  #2> echo "0-1" > A1/cpuset.cpus.exclusive 
>>  #3> echo "root" > A1/cpuset.cpus.partition
>>  #4> mkdir -p B1               
>>  #5> echo "0" > B1/cpuset.cpus 
>> 
>> Table 1: Current result
>>  Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>>  #1   | 0      |                |           | member       |              |
>>  #2   | 0      | 0-1            |           | member       |              |
>>  #3   | 0      | 0-1            |           | root         |              |
>>  #4   | 0      | 0-1            |           | root         | member       |
>>  #5   | 0      | 0-1            | 0         | root invalid | member       |
>> 
>
>I think this what we expect.
>
>> Table 2: Expected result
>>  Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>>  #1   | 0      |                |           | member       |              |
>>  #2   | 0      | 0-1            |           | member       |              |
>>  #3   | 0      | 0-1            |           | root         |              |
>>  #4   | 0      | 0-1            |           | root         | member       |
>>  #5   | error  | 0-1            |           | root         | member       |
>> 
>
>Step 5 should not return an error. As Longman pointed out, in cgroup-v2, setting cpuset.cpus should
>never fail.

Hi, Ridong,

Thank you for your correction. Will update.

Thanks,
Sunshaojie.

