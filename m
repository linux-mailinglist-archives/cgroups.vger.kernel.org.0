Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD494166683
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 19:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBTSpr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 13:45:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41259 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTSpr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 13:45:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so3617558qtr.8;
        Thu, 20 Feb 2020 10:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ajjnncCD8dG0G18fVGbEVN7FP1csi2qzGtdLhYXXJTU=;
        b=k/vpOSde9bMUoOkP1G2/1I25Nn9Pkv0cytj97/bjAuSIclk+m4KQ9S0ziULuviFMs9
         c6vb59sXLtBdSul8JNMDN9b22s/HaXZqEDqZVUUgXxNzpc7+RQuul8Lh87CBQrY8TG3b
         yeVKaW3Bcp9oIDJS2uYK6b0btASzCNPTQaNt4mwNERLhrW2G+KqIsbMBhMm9SXREycvV
         j/K7EMs16439ppT5r1FvGQRPftTQKxEEa69Oq9TofNUu2SJGZM7OqXVNPpPTYwvgce4v
         wW8oxpMW8jTdFf8kowzQY6+ON6pmqStIvwfyWeN0NhVNmwZhaMHrCqR6Xy/TfGZu19ch
         YULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ajjnncCD8dG0G18fVGbEVN7FP1csi2qzGtdLhYXXJTU=;
        b=MiRq1M5z2j8Q9wqPG6frhWM+vPmm7WO6XyCCCs/Tkm+ipxqpG7nxmbtmnTxbw6orvV
         L5/Ljy5/uDNrRftJNHdUqtsyFRd4cSGn8eZPrX4hgtYWBwRg1uXLmumZkoSVhauxnVqW
         QzBoHYp5aad9hI4Ong2BMmZEq9mVkEesJEtCjQ0yTN0Dzc/M2LMyRXLYqWVeYgsDkNbh
         UMmuFXr+pd4jg/ReTrOaj/yw1mXdZjxqfHMb+3wzCu4njHXRPMdZwuQvpjOj8ymSCtmw
         Q8HVtmWsg234cz5o3AUV+AqHQ6q3wJ0QSwoctPZO9F02qUr70pD6BJPRCZp1fnid3J8D
         sc5g==
X-Gm-Message-State: APjAAAVEAyNUc9I0VTRjqQ/EL+4ly9eTOpgY56rZoYBULxIXD+HBp07s
        YNassZs/2UiOtopRp1L2YsQ=
X-Google-Smtp-Source: APXvYqwr8QZEGjR+02xUZfnyfEhH/c3g1ZpRFCpisQx2XA9vthKAPCCYNwk1zQ/xPc6ejfIm8rgcFQ==
X-Received: by 2002:ac8:6054:: with SMTP id k20mr27102688qtm.92.1582224346333;
        Thu, 20 Feb 2020 10:45:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::55b1])
        by smtp.gmail.com with ESMTPSA id z1sm194156qtq.69.2020.02.20.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:45:45 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:45:45 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220184545.GH698990@mtj.thefacebook.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
 <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
 <20200220155651.GG698990@mtj.thefacebook.com>
 <20200220182326.ubcjycaubgykiy6e@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220182326.ubcjycaubgykiy6e@ca-dmjordan1.us.oracle.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 20, 2020 at 01:23:26PM -0500, Daniel Jordan wrote:
> The amount of work wouldn't seem to matter as long as the kernel thread stays
> in the cgroup and lives long enough.  There's only the one-time cost of
> attaching it when it's forked.  That seems doable for unbound workqueues (the
> async reclaim), but may not be for the network packets.

The setup cost can be lazy optimized but it'd still have to bounce the
tiny pieces of work to different threads instead of processing them in
one fell swoop from the same context, which most likely is gonna be
untenably expensive.

Thanks.

-- 
tejun
