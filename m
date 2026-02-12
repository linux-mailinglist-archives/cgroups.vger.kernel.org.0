Return-Path: <cgroups+bounces-13914-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDmqCrxEjmmPBQEAu9opvQ
	(envelope-from <cgroups+bounces-13914-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67C13139C
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C1AE304B82E
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4633A9EF;
	Thu, 12 Feb 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKQolMtp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3DF298CC9
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931380; cv=none; b=q90owa2A+hVb9NprAf1LBm3Td454Kr8OCVHVbtmeXw9glL7av0/thIi6cKFvm7yb3VlopTEguMKCDj3vTy5rYyBQtE5cHI4RXgSQ4QBbxuo/uJeIClZL05+odzKFNpTypU93rK3N6BluQ1c3Bkrkp4Q4wbhiENA29T4SBqHkVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931380; c=relaxed/simple;
	bh=FSqjcqciAdEJMHmURv6Wj+XypwEuC0lRa+6WDMtVmn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4/DYYMA5sLpd2KoWfzFnuc/lg/Vj6JZW1WUFMS6eMrlyQLC+i9/nYMWs8kbUAlCljCLG0EPMeZwg5EuC1LR2aX4yuXqpjePEPICmO03qs0GCJkYG9E1ECaLbh3kme0FcH31Dgmeyk3Uki+EsWuB3ctewEAO8JG/qWHEy6YOGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKQolMtp; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso510401eec.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931379; x=1771536179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jt/ta2e9LCcgP20HRiThdqdZNOrA6s81xaFb0uWeWU=;
        b=dKQolMtpMmuApjxGdivJL/zsYodWIJbEdJp8AZwKDJzRhW1hoAY1claDMgyvw+mm5N
         +tF8hzfTcbEfPUO/gE9XGutkHWCmT2vyNuPZUSy48XAXR//5dfBASSGbFnAFOnX7nwfW
         ant/YprhGc9IQoHpa1pKu3R5JDZm4gEC3bgoqnRTYKJRmtM/Ennvqe3kWZhuR2+ccz++
         QuztM4DTTwqWXtM1eIVSDMW8cQasJlU1FrvQJ52ScA1ByM4BYFnu1ZhgRLbwKtiDNAiy
         vvv8dtUEsv6TX3ng/YK05XC7H/kSvqk8r198OtN+ufoqVUzgKRYxF095nCCxbuNwsIYq
         +PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931379; x=1771536179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jt/ta2e9LCcgP20HRiThdqdZNOrA6s81xaFb0uWeWU=;
        b=EcqnrvXsguUlnfdb8PhmgU7YKLZa3fTWf/0MeqjjSbXJnjsSLqzBdsGziB+/rTdBph
         l8QlYCGi+wf+VRvfoOm9NWb/WDOvpX82tUbkH8SnHve0ZCJBMNP39TQiVoPDieYmPiOK
         QiqueA+Wwo6hY1Nn3LrlELfK7J/gt6avbY4klb16Y1IB67qa81LxjPPAvbAxEB80MbmQ
         tfhTxWCIs/kxqzzpDXnyaBH9aMzkrxk5YaAYQKYytoqYFKw+Dkw/KAryXob6DQbQEdOX
         mc3z6BAamJ1pJITEQnsCQQ7pJZ7F5SYJLmt+wJV6DvVU3k8+P4rE7vzdpsyR3qka2K8z
         689w==
X-Forwarded-Encrypted: i=1; AJvYcCWsv45iE6vNd/BiymOYwS+z+pB2O/sW8PZK49QsH5zBPUVdG84GDYps4ffiSPHSs5+vJZhJldDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyaApcSJCHS+nzLrFLd/Jl5IP/FQabqQEVch8Ikns9BD751MCqI
	TMCTihj6fokQGQA0BZS7VovzXM4Sjxh/9a32FSzqNIuRzI/labqtbRpu
X-Gm-Gg: AZuq6aLY95hBO24/zeC6m7Mwz3m1bSSLEY1+nbyQV8fwT8Z8SochywqXOJuCJrcuhRi
	yugUhfTfJMxV0JPeri+SoDCaWXOMF+6TkJpvAFXTjcu2lUx2qncrRI0Q3GfmKm8PB1fDHc/SkgI
	yS7z/Xfwy8FpIm40gzlerFBN5QTQmtZJoBBuBpohbzx0O/06sWdIeyO3aFFfrDajycQgSHCNaFz
	ESAEfwwKHhP5YCZ/M/TRdluwCQkAtAGCMRgK78Bhi0okwlL9VypP8oGE31GBd/6BxzkkbURH92p
	V1d4kdpOeGKGoIyfz0rG4pWVE8RHuUaOTGk9okk+XRsprmEWUkdM1WX8llRRvamxENATqmPoTHH
	cH2S0GZxDcErk7o9P75JDayRGZka8G9AVq7E8figG0MCW1ANlxtxOGsWl/ihPL/W2revGXt0nsJ
	KLrWbzl6k+qLnxdtMF26ouhC1j6dY66XEv4aiFxogk4Lo=
X-Received: by 2002:a05:7301:2f99:b0:2b7:2f29:648c with SMTP id 5a478bee46e88-2baba00663fmr143646eec.8.1770931378888;
        Thu, 12 Feb 2026 13:22:58 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2d44sm4184966eec.6.2026.02.12.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:22:58 -0800 (PST)
Message-ID: <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
Date: Thu, 12 Feb 2026 13:22:56 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY2BcIHIARSwwQpo@tiehlicka>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY2BcIHIARSwwQpo@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13914-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A67C13139C
X-Rspamd-Action: no action

On 2/11/26 11:29 PM, Michal Hocko wrote:
> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>> It would be useful to see a breakdown of allocations to understand which
>> NUMA policies are driving them. For example, when investigating memory
>> pressure, having policy-specific counts could show that allocations were
>> bound to the affected node (via MPOL_BIND).
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters can provide correlation between a mempolicy and pressure on a
>> given node.
> 
> Could you be more specific how exactly do you plan to use those
> counters?

Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
we identify the affected node(s), the new mpol counters (this patch)
allow us correlate the pressure to the mempolicy driving it.

