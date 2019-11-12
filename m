Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9929F9586
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKLQYz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 11:24:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39016 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLQYz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 11:24:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id t8so20386186qtc.6
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0a/sJJWyyFBbZkhKlYELP0090+55ZSiU8jLaE8NbD5U=;
        b=IhePBCHP1xPWJCnc0fhVuvGX81sL2k6BScL+Bp+yw2KH1UDC3HLFXYBUATgLx+0u3v
         3gpl92D1w8C8IuZpcc5/phnYVF2vimLZtVzNmmL/wOjbKhECk2jAoYWneZ8wLYEXskpx
         zUdNO45Dpq1aJZ271qIBeemjihB+/nrs71YJRPkYTbYpEx0zRFXtV/KwCscC74+ruEmj
         3MfrQbYRs9OTIoMoqQQy9qYXAZ2yMmPdsf5PUHTIwg1W3cnSfXXlOleyhBFUla1Dqq84
         sW88XHmq+3ktVLYs1u9fENB0/RRJoUkltX3Go4MifZFej10ejfv9DlLSbtvIb1raLmKF
         ox6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0a/sJJWyyFBbZkhKlYELP0090+55ZSiU8jLaE8NbD5U=;
        b=GgA+kqHvQDdD2bX8qA8RoooJT2c3BLmy8aKIZ3Isoi2ZUrQ54QwFMDLC6yEJu/ZyWF
         HXP+UUUr6LkwZVPG7kfNFUbHQdf+HB4Jjq92KfelxaHwW6Azb32UTUpSClyPfX579mDI
         k5jpF4xLdl8ZY+c8Df7d1rYWKBLyBAXWS6bhRxl/MDDAsUYzaJM9bnSsgl8FD3/WobUR
         vwHkTFJKyPeFNMkS/RqAW2ZBoS2OOhREqrlu56Cn5jmQiqhEFDHXMVLXCvNcuqP9/685
         +f2GEIwy0J60doJHIS89vdaxYvDBE+sWzej1Em2Ymle4PrcYUkE3qkkmr0XP2wLrYclJ
         khlQ==
X-Gm-Message-State: APjAAAVw3kC77jBc4IOe3N30rM0BNx/GGv3e7kWbr3rAy0LPYIuDsQLj
        qxw6+fKrbf5BOqVv2QV6PbiKiQ==
X-Google-Smtp-Source: APXvYqz+9z+j+VCCW6nt2U4oUrXjz30eoeX7U58SDkbPJV+nkekrKXRXSWXRfAcQWKcQxqzqxE0Dxg==
X-Received: by 2002:ac8:2a42:: with SMTP id l2mr32711563qtl.64.1573575894401;
        Tue, 12 Nov 2019 08:24:54 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 189sm9518840qki.10.2019.11.12.08.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:24:53 -0800 (PST)
Message-ID: <1573575891.5937.118.camel@lca.pw>
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, akpm@linux-foundation.org,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 11:24:51 -0500
In-Reply-To: <20191112161658.GF168812@cmpxchg.org>
References: <20191108204407.1435-1-cai@lca.pw>
         <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
         <20191111130516.GA891635@chrisdown.name>
         <20191111131427.GB891635@chrisdown.name>
         <20191111132812.GK1396@dhcp22.suse.cz>
         <20191112145942.GA168812@cmpxchg.org> <20191112152750.GA512@dhcp22.suse.cz>
         <20191112161658.GF168812@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2019-11-12 at 11:16 -0500, Johannes Weiner wrote:
> On Tue, Nov 12, 2019 at 04:27:50PM +0100, Michal Hocko wrote:
> > On Tue 12-11-19 06:59:42, Johannes Weiner wrote:
> > > Qian, thanks for the report and the fix.
> > > 
> > > On Mon, Nov 11, 2019 at 02:28:12PM +0100, Michal Hocko wrote:
> > > > On Mon 11-11-19 13:14:27, Chris Down wrote:
> > > > > Chris Down writes:
> > > > > > Ah, I just saw this in my local checkout and thought it was from my
> > > > > > changes, until I saw it's also on clean mmots checkout. Thanks for the
> > > > > > fixup!
> > > > > 
> > > > > Also, does this mean we should change callers that may pass through
> > > > > zone_idx=MAX_NR_ZONES to become MAX_NR_ZONES-1 in a separate commit, then
> > > > > remove this interim fixup? I'm worried otherwise we might paper over real
> > > > > issues in future.
> > > > 
> > > > Yes, removing this special casing is reasonable. I am not sure
> > > > MAX_NR_ZONES - 1 is a better choice though. It is error prone and
> > > > zone_idx is the highest zone we should consider and MAX_NR_ZONES - 1
> > > > be ZONE_DEVICE if it is configured. But ZONE_DEVICE is really standing
> > > > outside of MM reclaim code AFAIK. It would be probably better to have
> > > > MAX_LRU_ZONE (equal to MOVABLE) and use it instead.
> > > 
> > > We already use MAX_NR_ZONES - 1 everywhere else in vmscan.c to mean
> > > "no zone restrictions" - get_scan_count() is the odd one out:
> > > 
> > > - mem_cgroup_shrink_node()
> > > - try_to_free_mem_cgroup_pages()
> > > - balance_pgdat()
> > > - kswapd()
> > > - shrink_all_memory()

There is also inactive_list_is_low(),

if (trace)
	trace_mm_vmscan_inactive_list_is_low(pgdat->node_id, sc->reclaim_idx,
		lruvec_lru_size(lruvec, inactive_lru, MAX_NR_ZONES), inactive,
		lruvec_lru_size(lruvec, active_lru, MAX_NR_ZONES), active,
		inactive_ratio, file);

> > > 
> > > It's a little odd that it points to ZONE_DEVICE, but it's MUCH less
> > > subtle than handling both inclusive and exclusive range delimiters.
> > > 
> > > So I think the better fix would be this:
> > 
> > lruvec_lru_size is explicitly documented to use MAX_NR_ZONES for all
> > LRUs and git grep says there are more instances outside of
> > get_scan_count. So all of them have to be fixed.
> 
> Which ones?
> 
> [hannes@computer linux]$ git grep lruvec_lru_size
> include/linux/mmzone.h:extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
> mm/vmscan.c: * lruvec_lru_size -  Returns the number of pages on the given LRU list.
> mm/vmscan.c:unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
> mm/vmscan.c:    anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
> mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
> mm/vmscan.c:    file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
> mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
> mm/vmscan.c:            lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> [hannes@computer linux]$
> 
> The only other user already passes sc->reclaim_idx, which always
> points to a valid zone, and is initialized to MAX_NR_ZONES - 1 in many
> places.
> 
> > I still think that MAX_NR_ZONES - 1 is a very error prone and subtle
> > construct IMHO and an alias would be better readable.
> 
> I wouldn't mind a follow-up patch that changes this pattern
> comprehensively. As it stands, get_scan_count() is the odd one out.
> 
> The documentation bit is a good point, though. We should fix
> that. Updated patch:
> 
> ---
> 
> From b1b6ce306010554aba6ebd7aac0abffc1576d71a Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 11 Nov 2019 13:46:25 -0800
> Subject: [PATCH] mm: vmscan: simplify lruvec_lru_size() fix
> 
> get_scan_count() passes MAX_NR_ZONES for the reclaim index, which is
> beyond the range of valid zone indexes, but used to be handled before
> the patch. Every other callsite in vmscan.c passes MAX_NR_ZONES - 1 to
> express "all zones, please", so do the same here.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Reported-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index df859b1d583c..5eb96a63ad1e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -323,7 +323,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   * lruvec_lru_size -  Returns the number of pages on the given LRU list.
>   * @lruvec: lru vector
>   * @lru: lru to use
> - * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
> + * @zone_idx: index of the highest zone to include (use MAX_NR_ZONES - 1 for all)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
>  {
> @@ -2322,10 +2322,10 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	 * anon in [0], file in [1]
>  	 */
>  
> -	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
> -		lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
> -	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
> -		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
> +	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
> +		lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
> +	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
> +		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
>  
>  	spin_lock_irq(&pgdat->lru_lock);
>  	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
