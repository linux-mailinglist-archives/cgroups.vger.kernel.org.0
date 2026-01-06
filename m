Return-Path: <cgroups+bounces-12928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB04CF6F05
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 07:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1CA301CEBE
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6D30102C;
	Tue,  6 Jan 2026 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="G/vez5mI"
X-Original-To: cgroups@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F230214B
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682443; cv=none; b=IxqzTX0LBW/5etKCR4VCNNTmOczBlByMfy7oB6LHDsAvF6TewCvVxsov6aMoMx2s7Q+Yvg71yH/ewGlOiJQt+x99YrRVkNENoSVx0gYg9GTkxDdCfF53hRnZYvNoaACDsnNrPFnaniWc+jc5xhOr7V6jP8TM/f9bugpEFo3A/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682443; c=relaxed/simple;
	bh=ujjuPqYl39O51N9nKa7JvPk5vIzxNM+20Uw4oY+Agl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyMq2pgZ+BAXPgf4th8A6PzMrWh6DJPMg5/yx1pDB87+uy7HYbRlsfF044LvbTlqz5pj/ylabPNpfLNMxKHPPq55zsIuQj7qxvnxS9dYBb2lEsPF5Q4qragZ6Ji4TDZrEtUF40qmzBIIDTNc+2R+1UAc6ALWs1GKvuI/T3tjNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=G/vez5mI; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id cnhZvfUxNKXDJd0x6vq68R; Tue, 06 Jan 2026 06:54:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id d0x5vyYmPHSQMd0x5v9RPe; Tue, 06 Jan 2026 06:53:59 +0000
X-Authority-Analysis: v=2.4 cv=GIQIEvNK c=1 sm=1 tr=0 ts=695cb187
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Aea70ojWhvW6xI+oM0giEQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=fgAqcRqT0STgUfz1giMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MCst0vXTrl54MA5QK689mpZvQYuCeJQ5rEPbETOOHlY=; b=G/vez5mIJoapC1BKyFfPstgQf/
	yfFBDEawZrWjFtrTRNPEHqqUYrjgMg563y1RjKy3rofPcvBGYieRFV65EvDyvpkaM1BLqOXQ4b6J9
	y9Sc5uWkYWr/zOarUe5e8v3Pati9zuNbHpxvg5IrYBEDNNjSqWVtljju5sn+hGpBXCZ3quwTyLqq2
	yUAD9Ma4Rgb3/45VPmt0YxaOauUpBYyUjFSZkiqrymsHgZpi7qvyWnjVCTd8HNdZpcE2W5MmSCrSD
	kvIpLc8/1eS3djEQ0Jh+mOk/WDosBov94Sc9SL75BQPoZ1FUGoJo5s9J3OEP+hD0MCamd1XrEeZZ5
	1qleFl5A==;
Received: from flh4-122-130-137-161.osk.mesh.ad.jp ([122.130.137.161]:55764 helo=[10.221.196.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vd0x4-00000003kxS-1fbV;
	Tue, 06 Jan 2026 00:53:59 -0600
Message-ID: <8ac82e29-b193-4484-9bf4-19988d0141d6@embeddedor.com>
Date: Tue, 6 Jan 2026 15:53:50 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
 <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
 <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
 <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 122.130.137.161
X-Source-L: No
X-Exim-ID: 1vd0x4-00000003kxS-1fbV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-122-130-137-161.osk.mesh.ad.jp ([10.221.196.44]) [122.130.137.161]:55764
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKqcjn90MwWaJOXvKD9KNP1ANYcX2GMxXIZTDke0VaR2FTxe/RyM7p7G18Vo1fM7pgdatchn/2bzoblYzxaNEhJ3j46TzERz/8OYAqe7NKhuAe41MRQM
 RqrQFyISc58/DaULp1XIcq1Wntc7QIJWMfAL51PK9ETocRnZmACY6w/Ae+/5Y5RmY86kMLLASyj+NWOzF8/JhB1Jiy3XhHVtK1s=



On 12/19/25 01:32, Michal Koutný wrote:
> On Thu, Dec 18, 2025 at 06:09:42AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
>>> Note that this level may already be used in existing BPF programs (e.g.,
>>> tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consider compatibility here?
>>
>> That's a good point.
> 
> I wouldn't be concerned about this particular aspect. The commit
> e6ac2450d6dee ("bpf: Support bpf program calling kernel function")
> excludes ABIs, the example program uses ksyms (not kfuncs), so there
> could even apply Documentation/process/stable-api-nonsense.rst.
> OTOH, the semantics of level is unchanged for BPF helpers (that are the
> official API).
> 
> 
>> Is __counted_by instrumentation tied to some compiler flag? If so,
>> might as well make it an optional extra field specifically for the
>> annotation rather than changing the meaning of an existing field.
> 
> Honestly, I can see benefit mainly in the first patch of the series
> (posted the rest for discussion).
> 
> I'd like to ask Gustavo whether __counted_by here buys us anything or
> whether it's more useful in other parts of kernel (e.g. flexible
> allocations in networking code with outer sources of data).

Ideally, all structures containing a flexible-array member (FAM) should
be annotated. However, if this is too much of a hassle right now, I'd
say the priority is to avoid the -Wflex-array-member-not-at-end warnings,
first.

Thanks
-Gustavo


