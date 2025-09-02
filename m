Return-Path: <cgroups+bounces-9609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B647B3F736
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4201A87A3A
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F22E8E04;
	Tue,  2 Sep 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MUsO79ux"
X-Original-To: cgroups@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0002E8B9C
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799809; cv=none; b=J1+hI305HgyqVHLeqeNcHlHxLtL7fosmqq7puvPFPMqIdSWnEDhQyjl0ZGdpFKB0ZK7ITQql6f3gmO0sr1XTVn4Z1GGR1lhfH3JFsOjpKLe77hoWRopnLZJilqJvQZbIWNFIReM653P36MiDcyxnOWin5X649JFIyRisNI/H71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799809; c=relaxed/simple;
	bh=Yk18SBQzoXAjnIAWv+ffWMWjIUs8ABHusclWRbr8Yi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jg2L5mzzVz09P/5vYZ87ueqdWHY9kfyFBI9Af+mVz9z+J633/wOpq5DwEOz60Zi7YemngZ/T4b1yxo1d6i52LnIoGNxHq80JpngteGzAN1wFzFr4gcElrlWKT0TPjIxPCFsnsBqZp3m6eXMhcOaJReAdABzL46/rQkrttkvQUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MUsO79ux; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id tIBfu5zvSaPqLtLskuXyeq; Tue, 02 Sep 2025 07:56:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tLsiuUzwzOhG0tLsju7pSn; Tue, 02 Sep 2025 07:56:45 +0000
X-Authority-Analysis: v=2.4 cv=PIgP+eqC c=1 sm=1 tr=0 ts=68b6a33d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=lix9ENjbuMu12OTMD5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=okXODQ+jKSpaf8IXKd7wjaUPjNu4b3AlYTLZMl40oYc=; b=MUsO79uxb/9Xu+nHgDBocU/0sa
	xre8NgTKO9dYx+uUBydBAXXmmF+K+sEpVMJ+4qQ11nlH5yWauq7RmXl3+TCQgpTeusW6C4SoWTRyB
	XUgQev4utosfhcpT8mw6G9qBg3Hndo3M0PhFRCzXGkoH7a1eOBLkVOIl2ZQYMJqgoWq7lFB9uSCEn
	8M9YSl1W0yTXGLOYOxToZVm14CoySxUTaZwTU/s1OMMsS+hVwqP7BRg/QSZodl3ZmCDX3MSrXWXB1
	vNG/VRF7+WtVmb5LOqIe2cVSN8hEvtw5EMKX5wnYka0h4/D6bio7JCELL3dborg5jVJrE7RvfuTL+
	U1swrEWg==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:47322 helo=[10.28.188.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1utLsh-00000002QXb-3nRk;
	Tue, 02 Sep 2025 02:56:44 -0500
Message-ID: <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
Date: Tue, 2 Sep 2025 09:56:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1utLsh-00000002QXb-3nRk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([10.28.188.44]) [212.178.105.130]:47322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPaYGG2ZzGWnav2ZMyceLIhqudOw2fBFxnKhiyAMX5XyzMh58QWeoA9lAyBIRLJ9g6P0cmiFWpg2exdQIiJTKVv6m/qxuRsWPvX0WY47priRitEYQO56
 K76FkA6Z+9jPj7tOxEMzbE2lVYVA8tcjTRC8optWcSBSI67H5fBmfk7YiEhQpX0B91nG3PVf7SxYdpQPcQc68Kml7uwDNDKWuDc=



On 9/1/25 19:58, Michal Koutný wrote:
> On Mon, Sep 01, 2025 at 05:21:22PM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> Because struct cgroup ends in a flexible-array member `ancestors`.
>> This triggers the -Wflex-array-member-not-at-end warns about. So,
>> while `ancestors` is indeed a flexible array, any instance of
>> cgroup embedded in another struct should be placed at the end.
> 
> Oh, so TRAILING_OVERLAP() won't work like that?
> (I thought that it'd hide the FAM from the end of the union and thus it
> could embedded when wrapped like this. On second thought, I realize
> that's exclusive with the static validations.)
> 
>> However, if we change it to something like this (and of course
>> updating any related code, accordingly):
>>
>> -       struct cgroup *ancestors[];
>> +       struct cgroup **ancestors;
>>
>> Then the flex in the middle issue goes away, and we can have
>> struct cgroup embedded in another struct anywhere.
>>
>> The question is if this would be an acceptable solution?
>>
>> I'd probably prefer this to remain a flexible-array member,
>> but I'd like to hear people's opinions and feedback. :)
> 
> I'd prefer if cgroup_create could still work with one allocation only
> both for struct cgroup and its ancestors array. (Cgroup allocation
> happens many times in a day.)
> 
> The increase in struct cgroup_root size is IMO not that problematic.
> (There are typically at most CGROUP_SUBSYS_COUNT roots with gradual
> trend to only the single cgrp_dfl_root.)
> 
> Note that it'd be good to keep it enclosed within struct cgroup_root
> (cgroup1_root_to_use could use struct_size()), however, the
> cgrp_dfl_root would still need the storage somewhere.

If the increase in size is not a problem, then something like this
works fine (unless there is a problem with moving those two members
at the end of cgroup_root?):

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38..bd28d639a78a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -630,16 +630,6 @@ struct cgroup_root {
         struct list_head root_list;
         struct rcu_head rcu;    /* Must be near the top */

-       /*
-        * The root cgroup. The containing cgroup_root will be destroyed on its
-        * release. cgrp->ancestors[0] will be used overflowing into the
-        * following field. cgrp_ancestor_storage must immediately follow.
-        */
-       struct cgroup cgrp;
-
-       /* must follow cgrp for cgrp->ancestors[0], see above */
-       struct cgroup *cgrp_ancestor_storage;
-
         /* Number of cgroups in the hierarchy, used only for /proc/cgroups */
         atomic_t nr_cgrps;

@@ -651,7 +641,21 @@ struct cgroup_root {

         /* The name for this hierarchy - may be empty */
         char name[MAX_CGROUP_ROOT_NAMELEN];
+
+       /*
+        * The root cgroup. The containing cgroup_root will be destroyed on its
+        * release. cgrp->ancestors[0] will be used overflowing into the
+        * following field. cgrp_ancestor_storage must immediately follow.
+        *
+        * Must be last --ends in a flexible-array member.
+        */
+       TRAILING_OVERLAP(struct cgroup, cgrp, ancestors,
+               /* must follow cgrp for cgrp->ancestors[0], see above */
+               struct cgroup *cgrp_ancestor_storage;
+       );
  };
+static_assert(offsetof(struct cgroup_root, cgrp.ancestors) ==
+             offsetof(struct cgroup_root, cgrp_ancestor_storage));


The assert above checks that no misalignment is inadvertently
introduced between FAM and cgrp_ancestor_storage.

Thanks
-Gustavo



