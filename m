Return-Path: <cgroups+bounces-8699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A42AFB6A7
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A055E3A8745
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D092BEC39;
	Mon,  7 Jul 2025 15:00:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA311A238A
	for <cgroups@vger.kernel.org>; Mon,  7 Jul 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900429; cv=none; b=T+ifUHW9P8RzB+Bx8cUR3GeVhaD+jG+dMzCEl/DaKh+YNAhICyqmoWWI5Xfy7ytDOHUBqgTJhLnxyS09D3Hp1iY2htFyrUzNMBM4jBRCDQ43zoYhHXp9CbaWERVvxljaT98c+tPi1iihQiMm4gTkSjPcbxyuTZlIazQrl/7+MfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900429; c=relaxed/simple;
	bh=tzJDDfDgVvwSOVvEga/nDK+KU2Bmv+Hr9yybDjPvMFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD3gN5g2xFC6EYUG+ZFY45kSM14hzj89eGPXM55eHGO9z4hlhy/mEHLZXvF/e8KCpjwP7WkkE9bVNchMEK1VfFPKkxsERpktQnUfqya62MaNBkKAU3takCGDNwhkHFJcLyEWslZmKe0ldYDyFa+6tYFDlFjresMMhnrEcQNh4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 7 Jul 2025 23:45:25 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 7 Jul 2025 23:45:25 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	muchun.song@linux.dev, iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <aGvdhXFtVDR60MMn@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
 <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
 <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>
 <aGPd3hIuEVF2Ykoy@yjaykim-PowerEdge-T330>
 <nyzhn5e5jxk2jscf7rrsrcpgoblppdrbi7odgkwl5elgkln4bq@mdhevtbwp7co>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nyzhn5e5jxk2jscf7rrsrcpgoblppdrbi7odgkwl5elgkln4bq@mdhevtbwp7co>

On Mon, Jul 07, 2025 at 11:59:49AM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, Jul 01, 2025 at 10:08:46PM +0900, YoungJun Park <youngjun.park@lge.com> wrote:
> >   memory.swap.priority
> ...
> 
> >         To assign priorities to swap devices in the current cgroup,
> >         write one or more lines in the following format:
> > 
> >           <swap_device_unique_id> <priority>
> 
> How would the user know this unique_id? (I don't see it in /proc/swaps.)

The unique_id is a new concept I introduced to refer to assigned
swap devices. It's allocated whenever a swap device is turned on. I did
explore other key identifiers like the swap device path, but I
determined that providing a separate unique_id is more suitable for
this context. Initially, I proposed printing it directly from
memory.swap.priority to facilitate usage like:

$ swapon
NAME       TYPE      SIZE USED PRIO
/dev/sdb   partition 300M  0B   10
/dev/sdc   partition 300M  0B    5

$ cat memory.swap.priority
Active
/dev/sdb   unique:1  prio:10
/dev/sdc   unique:2  prio:5
Following your suggestion, I've deprecated this initial proposal and
considered four alternatives. I'm currently leaning towards
options 2 and 4, and I plan to propose option 4 as the primary
approach:

1. /proc/swaps with ID: We've rejected this due to potential ABI
changes.

2. New /proc interface: This could be /proc/swaps with the ID,
or a dedicated swapdevice file with the ID. While viable, I prefer
not to add new /proc interfaces if we can avoid it.

3. /sys/kernel/mm/swap/ location: (Similar to vma_ra_enabled)
This was rejected because sysfs typically shows configured values,
not dynamic identifiers, which would be inconsistent with existing
conventions.

4. Align memory.swap.priority.effective with /proc/swaps:
Aligning the order of id prio pairs in
memory.swap.priority.effective with the output order of
/proc/swaps would allow users to infer which swap device
corresponds to which ID. For example:

$ swapon
NAME       TYPE      SIZE USED PRIO
/dev/sdb   partition 300M  0B   10
/dev/sdc   partition 300M  0B    5

$ cat memory.swap.priority.effective
Active
1 10     // this is /dev/sdb
2 5      // this is /dev/sdc

> >         Note:
> >           A special value of -1 means the swap device is completely
> >           excluded from use by this cgroup. Unlike the global swap
> >           priority, where negative values simply lower the priority,
> >           setting -1 here disables allocation from that device for the
> >           current cgroup only.
> 
> The divergence from the global semantics is little bit confusing.
> There should better be a special value (like 'disabled') in the interface.
> And possible second special value like 'none' that denotes the default
> (for new (unconfigured) cgroups or when a new swap device is activated).
> 

Thank you for your insightful comments and suggestions regarding the
default values. I was initially focused on providing numerical values
for these settings. However, using keywords like "none" and
"disabled" for default values makes the semantics much more natural
and user-friendly.

Based on your feedback and the cgroup-v2.html documentation on default
values, I propose the following semantics:

none: This applies priority based on the global swap
priority. It's important to note that for negative priorities,
this implies following NUMA auto-binding rules, rather than a direct
application of the negative value itself.

disabled: This keyword explicitly excludes the swap device
from use by this cgroup.

Here's how these semantics would translate into usage:

echo "default none" > memory.swap.priority or
echo "none" > memory.swap.priority:
* When swapon is active, the cgroup's swap device priority will
follow the global swap priority.

echo "default disabled" > memory.swap.priority or
echo "default" > memory.swap.priority:
* When swapon is active, the swap device will be excluded from
allocation within this cgroup.

echo "<id> none" > memory.swap.priority:
* The specified swap device will follow its global swap priority.

echo "<id> disabled" > memory.swap.priority:
* The specified swap device will be excluded from allocation for
this cgroup.

echo "<id> <prio>" > memory.swap.priority:
* This sets a specific priority for the specified swap device.

> ...
> >         In this case:
> >           - If no cgroup sets any configuration, the output matches the
> >             global `swapon` priority.
> >           - If an ancestor has a configuration, the child inherits it
> >             and ignores its own setting.
> 
> The child's priority could be capped by ancestors' instead of wholy
> overwritten? (So that remains some effect both.)

Regarding the child's priority being capped or refined by ancestors'
settings, I've considered allowing the child's priority to resolve its
own settings when the sorted priority order is consistent and the
child's swap devices are a subset of the parent's. Here's a visual
representation of how that might work:

+-----------------+
| Parent cgroup   |
| (Swaps: A, B, C)|
+--------+--------+
         |
         | (Child applies settings to its own children)
         v
+--------+--------+
| Child cgroup    |
| (Swaps: B, C)   |
| (B & C resolved by child's settings)
+--------+--------+
         |
         +-------------------+
         |                   |
         v                   v
+--------+--------+   +--------+--------+
| Grandchild cgroup |   | Grandchild 2 cgroup |
| (Swaps: C)        |   | (Swaps: A)        |
| (C resolved by    |   | (A not in B,C;    |
|  grandchild's     |   |  resolved by      |
|  child's settings)|   |  child's settings)|
+-------------------+   +-------------------+

However, this feature isn't currently required for our immediate use
case, and it adds notable complexity to the implementation. I suggest
we consider this as a next step if the current feature is integrated
into the kernel and sees widespread adoption or
any further use cases or requirements.

Best regards,
Youngjun Park

