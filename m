Return-Path: <cgroups+bounces-12033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30490C62997
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 07:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AA23AF016
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886A315D49;
	Mon, 17 Nov 2025 06:54:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9525BEE7;
	Mon, 17 Nov 2025 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362487; cv=none; b=F6K8p5UEdeclo9d3leLWrLfi7Z4z4sUjnOKCmyQr7lXSR+jzEQyfDVPkk2TV1eS4lpbMq74Ta4nS0bKkfesrDscYGS3T2GBo35zlNdEsKH0daGvBjT1u007SmRomnqltGDD73/MS/dCKHHocYAV/hkQhpeqKLuU3zG9ThqBT8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362487; c=relaxed/simple;
	bh=pCEsrFTCK7FWrnZMnnX4UKWTTuEtyJT7mkzJDVDqr+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrBOMoAjTzKp2IwhzpajJ4iazbDK4bVlIb0Fc5kT91aKhvvKb/O4eY6rR2oGzQ9uFyHFd5LP60RaBMc47JT4UtbjTpC+LPRfdRh/Y6ztt8vCNdK8tXYLMyX9UCKFKO7JSR842Afxs/uznmmeHDFA/CA5a+cM5HSqM1/b1T23950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 468a5b6ec38211f0a38c85956e01ac42-20251117
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:05df1a68-1303-4f6a-acb7-4561095024c9,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:05df1a68-1303-4f6a-acb7-4561095024c9,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:83f0999120363bb5d2625d481f313a9a,BulkI
	D:2511171235311XBXILTJ,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 468a5b6ec38211f0a38c85956e01ac42-20251117
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 803511238; Mon, 17 Nov 2025 14:54:34 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mkoutny@suse.com,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
Date: Mon, 17 Nov 2025 14:53:47 +0800
Message-Id: <20251117065347.1052678-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a16c91d9-a779-44e5-9ca6-e14e7540ed69@huaweicloud.com>
References: <a16c91d9-a779-44e5-9ca6-e14e7540ed69@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025/11/15 14:23, Chen Ridong wrote:
>On 2025/11/17 12:35, Sun Shaojie wrote:
>> Hi, Ridong,
>> 
>> Maybe, this patch does not apply to the following cases:
>>  Step
>>  #1> echo "root" > A1/cpuset.cpus.partition
>>  #1> echo "0-1" > B1/cpuset.cpus
>>  #2> echo "1-2" > A1/cpuset.cpus.exclusive  -> return error
>>  It should return success here.
>> 
>> Please consider the following modification.
>> 
>
>If A1 will automatically change to a valid partition, I think it should return error.

Hi, Ridong,

A1 will not automatically change to a valid partition.

Perhaps this example is more intuitive.

For example:

 Before apply this patch:
 #1> echo "0-1" > B1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition -> A1's prstate is "root invalid"
 #3> echo "1-2" > A1/cpuset.cpus.exclusive
 Return success, and A1's prstate is "root invalid"

 After apply this patch:
 #1> echo "0-1" > B1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition -> A1's prstate is "root invalid"
 #3> echo "1-2" > A1/cpuset.cpus.exclusive
 Return error, and A1's prstate is "root invalid"

 It should return success here. Because A1's prstate is "root invalid.
 
For this example, the behavior should remain consistent before and after 
applying the patch. This is because when A1 is in the "root invalid" state,
its behavior is equivalent to that of a "member," meaning A1's 
cpuset.cpus.exclusive and B1's cpuset.cpus are allowed to overlap.

Thanks,
Sun Shaojie

