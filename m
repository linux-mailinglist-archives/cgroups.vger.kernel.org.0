Return-Path: <cgroups+bounces-15182-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLeJEckb1Wli0wcAu9opvQ
	(envelope-from <cgroups+bounces-15182-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3193B0826
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55CF53019802
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC2529AAEA;
	Tue,  7 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuKWF9om"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191C33C53F;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573745; cv=none; b=O5PCQJaVboJrV2iP9CVNYIbkNQYD64ZylawlSM5i/Myh5JaqI3cqDNsNdjFyhSSHMTmtpxM7PRi9zTnCA/fOZvrAjmRU79di6sHGSdoXbnqgSVByXVFg+PUvefGvpMZD70xWKpe2Rq1qrwxq7GqGz9dw8fUFiFAGntfBkt4cEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573745; c=relaxed/simple;
	bh=ktiFYUkm17rtWG9ixEvpBIbYQmlh9KYi2e+f5EL5XCo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WS864xMTQ70NrDum2NwJpiPDeyxGq9bI+ztGcwQHj1LHnsHGdH7DbgSBN3I19rOLqH24UtTm5rnI19xgqm3anwO6wmIlKVqMP6FWMyRkSdG7mbqPcaa92R8H0MPG7IkXHE5W3VfCQ+R5eUNmuOqu2OvOpIbdp+SjJ7hJz3gdmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuKWF9om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B09FC116C6;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775573745;
	bh=ktiFYUkm17rtWG9ixEvpBIbYQmlh9KYi2e+f5EL5XCo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NuKWF9omdnJ/bEfLNjGfch+1eL25hNaS1FkAdfhjVmoIKIGQsNKQMkFLcYPDch7ux
	 gJqBwlgxHIhG7lF4+4hjPhm6JT99+VfGtt1m1MjCdxAxN9P6Qh6HrumepvTHgXaxn0
	 0lOGHlczXAY59ch/2fZBw3OBWwrKe9BMm2Bg0wpPSyJv0YValhgTedbv3DiKRNiu+7
	 DhmruK9l28zjYKbiQmoCZMC6K4tXw+YVuUUXms3rREaBTAfEA5IEp1VNSlM+2xhibJ
	 S2znC6naxkqHlf02+taUh1WnMD+1RAhTYT6CeWLqW7o9ijyASNv1FbCw15ZY88LqoV
	 kDeV5ZEoM7d4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D4FEEF52;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH RFC 0/2] mm, swap: fix swapin race that causes inaccurate
 memcg accounting
Date: Tue, 07 Apr 2026 22:55:41 +0800
Message-Id: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNz3eLyxALd3NTc5HTdtMwKXcuUJIOk5GTjtERzMyWgpoKiVKAw2MB
 opSA3Z6VYiGBxaVJWanIJyCil2loA+uYQK3cAAAA=
X-Change-ID: 20260407-swap-memcg-fix-9db0bcc3fa76
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775573744; l=5405;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=ktiFYUkm17rtWG9ixEvpBIbYQmlh9KYi2e+f5EL5XCo=;
 b=4buYa029bKRDja+FudcwHiadO4RPbc7haNQ9UhhSEB6duzxw3I44ZRV4k0i+0hQXiX0dnEc5j
 Gkfn3V+rOu8CBGklC4jLMUdhig4dBZdcjwMZoWpvGy1ZQEwwSOWBEM3
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15182-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,lge.com,cmpxchg.org,ghiti.fr,oracle.com,google.com,suse.com,linux.alibaba.com,oppo.com,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email,tencent.com:replyto,tencent.com:mid]
X-Rspamd-Queue-Id: DD3193B0826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While doing code inspection, I noticed there is a long-existing issue
THP swapin may got charged into the wrong memcg since commit
242d12c981745 ("mm: support large folios swap-in for sync io devices").
And a recent fix made it a bit worse.

The error seem not serious. The worst that could happen is slightly
inaccurate memcg accounting as the charge will go to an unexpected but
somehow still relevant memcg. The chance is seems extremely low.
This issue will be fixed (and found during the rebase of) swap table P4
but may worth a separate fix. Sending as RFC first in case I'm missing
anything, or I'm overlooking the result, or overthinking about it.

And recent commit 9acbe135588e ("mm/swap: fix swap cache memcg
accounting") extended this issue for ordinary swap too (see patch 1 in
this series). The chance is still extremely low and doesn't seem to have
a significant negative result.

The problem occurs when swapin tries to allocate and charge a swapin
folio without holding any lock or pinning the swap slot first. It's
possible that the page table or mapping may change. Another thread may
swap in and free these memory, the swap slots are also freed. Then if
another mem cgroup faulted these memory again, thing get messy.

Usually, this is still fine since the user of the charged folio -
swapin, anon or shmem, will double check if the page table or mapping
is still the same and abort if not. But the PTE or mapping entry could
got swapped out again using the same swap entry. Now the page table or
mapping does look the same. But the swapout is done after the resource
is owned by another cgroup (e.g. by MADV & realloc), then, back to the
initial caller the start the swapin and charged the folio, it can keep
using the old charged folio, which means we chaged into a wrong cgroup.

The problem is similar to what we fixed with commit 13ddaf26be324
("mm/swap: fix race when skipping swapcache"). There is no data
corruption since IO is guarded by swap cache or the old HAS_CACHE
bit in commit 242d12c981745 ("mm: support large folios swap-in for sync
io devices").

The chance should be extremely low, it requires multiple cgroups to hit
a set of rare time windows in a row together, so far I haven't found a
good way to reproduce it, but in theory it is possible, and at least
looks risky:

CPU0 (memcg0 runnig)                | CPU1 (also memcg0 running)
                                    |
do_swap_page() of entry X           |
<direct swapin path>                |
<alloc folio A, charge into memcg0> |
... interrupted ...                 |
                                    | do_swap_page() of same entry X
                                    | <finish swapin>
                                    | set_pte_at() - a folio installed
                                    | <frees the folio with MADV_FREE>
                                    | <migrate to another *memcg1*>
                                    | <fault and install another folio>
                                    |   the folio belong to *memcg 1*
                                    | <swapout the using same entry X>
... continue ...                    |   now entry X belongs to *memcg 1*
pte_same() <- Check pass, PTE seems |
              unchanged, but now    |
              belong to memcg1.     |
set_pte_at() <- folio A installed,  |
                memcg0 is charged.  |

The folio got charged to memcg0, but it really should be charged to
memcg1 as the PTE / folio is owned by memcg1 before the last swapout.
Fortunately there is no leak, swap accounting will still be uncharging
memcg1. memcg0 is not completely irrelevant as it's true that it is now
memcg1 faulting this folio. Shmem may have similar issue.

Patch 1 fixes this issue for order 0 / non-SYNCHRONOUS_IO swapin, Patch
2 fixes this issue for SYNCHRONOUS_IO swapin.

If we consider this problem trivial, I suggest we fix it for order 0
swapin first since that's a more common and recent issue since a recent
commit.

SYNCHRONOUS_IO fix seems also good, but it changes the current fallback
logic. Instead of fallback to next order it will fallback to order 0
directly. That should be fine though. This issue can be fixed / cleaned
up in a better way with swap table P4 as demostrated previously by
allocating the folio in swap cache directly with proper fallback and a
more compat loop for error handling:

https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-4-104795d19815@tencent.com/

Having this series merged first should also be fine. In theory, this
series may also reduce memcg thrashing of large folios since duplicated
charging is avoided for raced swapin.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Kairui Song (2):
      mm, swap: fix potential race of charging into the wrong memcg
      mm, swap: fix race of charging into the wrong memcg for THP

 mm/memcontrol.c |  3 +--
 mm/memory.c     | 53 ++++++++++++++++++++-------------------------
 mm/shmem.c      | 15 ++++---------
 mm/swap.h       |  5 +++--
 mm/swap_state.c | 66 +++++++++++++++++++++++++++++++++++++++++----------------
 5 files changed, 79 insertions(+), 63 deletions(-)
---
base-commit: 96881c429af113d53414341d0609c47f3a0017c6
change-id: 20260407-swap-memcg-fix-9db0bcc3fa76

Best regards,
--  
Kairui Song <kasong@tencent.com>



