Return-Path: <cgroups+bounces-13916-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO59JehEjmmPBQEAu9opvQ
	(envelope-from <cgroups+bounces-13916-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6D1313BB
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0BBD30E0DF8
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EB32C95B;
	Thu, 12 Feb 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUS1NIU0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35962F3601
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931426; cv=none; b=GiWEI1tzyc47fOqufPl3F3xMjhCgCdbzr7brXrBmn4qM82ikgEyRONVphYyCmwxccVugE9AcFa84f+R4St8WZmojxOKOMhZz2auuo2CGTiEc/cjCVuyd4ebavybLe57UQe2Vw8xxkMr628TQ0dRiLR70VXF8wk7sZQcZv/RI214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931426; c=relaxed/simple;
	bh=rMNumwSZt3E/SAqI1m3Arbs/q+SzJAFwiaJFsh0Uccw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy9Oe6abTvcyCRuxOy4ThNZT4Sza7D2TcpirCZctSLKsxqOYJpVWrh+FXxtC8FM+wgGN58nigg3IwhLGriUozqIcHfaeTFZqRUn3plLWj4Sp0zEZnLw9VMOY1yA7sZl5tpWUhEF0s3ri6Es2CfEyIN/pTP53hiGjEExs2Uy6PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUS1NIU0; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so731533c88.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931425; x=1771536225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urRGhY6imA3+iq+NIxaKfTA3oOAFaO2s3SPb2rxYQCM=;
        b=CUS1NIU0kTs16Wm1NQOtwAIpGGZGBFx//UYRtBJkircXSHueJsZTrJgBqEoschlNWZ
         ZM5jv683pWmi30nYVdymybBYrT230A9UGmqiWGPsT9zrrh4mHKLLUM5Tt6VfSyMbCYB5
         UrLUN6d0TZZY/NyeMAwgujo4H2OmWnblPwcfCCuPX8QOS1DlCt2RJPmVTI2dMCP/AjSR
         VA69bJ2+SUC1WXpvDFmy/tmZzrPhfncK3ueamaZY9uqjPmgpxwHHygux0mqn6nilfTFz
         YojB6mliL5JRvFmqjOLzfpQA+DOtksZ/yieMa25H9+9NEsYjSdWxrtEV+bOeHr4hcC65
         jq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931425; x=1771536225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urRGhY6imA3+iq+NIxaKfTA3oOAFaO2s3SPb2rxYQCM=;
        b=YOdoYvB1ZeuZy2k/+tcJdtPmZUePtGxrDya3irRGqIEm7gGzRKH+bGYxIpAdC2ZejF
         ddSQyBc3cgwwYkCQb8BFVjeLtPk8XaDxusbiXAB+05kZoHMnW56k0tFqASFK6R9bMfYY
         kP+FzOHW0ucHCjza4afRcJ1nBL1t1zPTuxcoKnomsYKi2dsZQJnv1S2WM+OV/xcMcI6a
         z4JF+ohFBeHfPw/wltokvimo0H3bWB7/yaDgXlHkY23TLfmn2HCLPKQN8cmYG0BTQdek
         JAAOplXaxUxT7sa1vWrBl/lBQLICPkgYU2RbgLfIkTB59V2UBMyhvkeTtyRC9mRa4ciR
         LOxA==
X-Forwarded-Encrypted: i=1; AJvYcCWYlJ9Li+e+PPlPmPg4J/0SyNKMNSJbEIux0jjAke/lH27DZMlC9hT2/dXjWZg/83yvdrLbRJNd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNldXmIq6xIZRvJBuDjwH1PpJiXL2+oL0BUp9tgcS0oaeNwbae
	R0mK5sSGK3Gre8xFeKrgp6/2ekRsBGHK8ZugNeXNZq7ETvui+CxtHUW/
X-Gm-Gg: AZuq6aLe7rPEg/6UHiygyCyIZHMImjUoevGr++/+B5DsaH8VXcMH4k7S63JQgvrhnBJ
	e+H/Hvlv7Nc07DkczexYKIrjLexaV3YF50SMxQjw/8qD2I+73ktQJUambFdyg56QeSbFoeOvDv+
	T/fF1ShcLmwrNOvB8mWWz/YVtpE+YXYMvQcBqImQClhvwe4IV0XCfpNJdMqKAGCMDxesmQOzfr4
	4dmd2sDHQg1RxamV2WauEcDQ1NuvYO5unGbSJGD+4nchEi+XXzJgmNaHBQqBXNNmZ93jKQDzVcx
	4qcR2Nslc4uIyql2MJJPDFiWlirSMbbUDpvHOUCvm9/tAkgl2U6HH8cRfxgXRa2hLf2nI1s7jG3
	HbSGWSchehUs5KXgeSz8DEOOWu72qwhoya29TVBUXAByhn3Ng/axr08H5QHm0cw5aK69kxKVaBy
	riml20DUc1w6waCGH3JAl2ZJf8UI3+1OF/
X-Received: by 2002:a05:7300:fd15:b0:2ba:a2fa:84a6 with SMTP id 5a478bee46e88-2baba0e3898mr151831eec.24.1770931424978;
        Thu, 12 Feb 2026 13:23:44 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcea9b7sm4192869eec.25.2026.02.12.13.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:23:44 -0800 (PST)
Message-ID: <fc29d4fe-2d85-440c-a8db-c26520dd4fc8@gmail.com>
Date: Thu, 12 Feb 2026 13:23:42 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: move pgscan and pgsteal to node stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mhocko@suse.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-3-inwardvessel@gmail.com>
 <20260212020724-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20260212020724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13916-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1A6D1313BB
X-Rspamd-Action: no action

On 2/11/26 11:08 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 11, 2026 at 08:51:09PM -0800, JP Kobryn wrote:
>> It would be useful to narrow down reclaim to specific nodes.
>>
>> Provide per-node reclaim visibility by changing the pgscan and pgsteal
>> stats from global vm_event_item's to node_stat_item's. Note this change has
>> the side effect of now tracking these stats on a per-memcg basis.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> virtio_balloon changes

Thanks. I'll make sure to spell this out in the v2 changelog.

