Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF21B379E
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVGlO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgDVGlN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:41:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFFAC03C1A6;
        Tue, 21 Apr 2020 23:41:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so480527pjb.1;
        Tue, 21 Apr 2020 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FFXai4lc3A2Whp3tdpgUAfuzp8AdGL6AbM8bh1FKhoI=;
        b=aI4nuWwFYpWsS6XMk0wXURr5G6Xw02o7k3duOBm1u+gFfd6YvOPycF2KeoevA0D2RK
         DRoP8twmMMiHQSrfQT3OOXKpZhwn+UCkFN0U6C4rC6gX9mPO85rkRp2aATBkM5i3zVIX
         SPAivrjIQHswt90xXmtCxNwbGg4GJGIkc3dLR9NqM8238/dWYqSJVaILrB5TRAQqgQEk
         DVk6wig4C8alf433BjHDMXmdLyDmwAx6l0bFs0Z+HRUmslyho8mkVBlJoivHhEFu0NjB
         VRHSgcNdxRzUkD7b/uU110jv81DkhGL6B+XOLvW3t6FstiE8e7TJteA3XP+3f9bzqit0
         Hwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFXai4lc3A2Whp3tdpgUAfuzp8AdGL6AbM8bh1FKhoI=;
        b=OciI+OscOgx1vzzu9OLkVMiDSYodgAb0frkzWiRYu7uVPft898LddSI0wY+SF6mBLg
         AAkBZVOR4ADa3bAPytUyhwoJMf3nl49bjgbyY3SojowgIOnuM1jMwUDEFzaS7UAN68AJ
         Fx2edQCgWv8gy7qSUsYdPrT+LDFhoVy7gT8q8LnAvanNS9+UKMAepx7Mvz0UIJF1rfCV
         V8Xt725RiDxeZ0bbqzJVsKGgiMNWCMO5wqNeBy10Hby24Hyk7bYTKrLXzvo9syYD8WaH
         krXUwoiSdzOKlgxP9D9ZgmF1mvnMhPbvl0uz14SCa6a7DtX7edW+PlB4xUMk6zc8jx4o
         VyOw==
X-Gm-Message-State: AGi0PuYvePc2h3Zg6v16qL/6onm5xNn6DZ+9S7geQ+ZJvHJ06F8g8dfp
        ppz6XzcQo5SAwt/wdJM4Smk=
X-Google-Smtp-Source: APiQypI1xYbgbSewLWPzAya/EKYVSEyVWI5wgtJNRZIgDV+apAtS1JvgPCAh7R/SoQRmn/OlZNWtvA==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr25871547plo.60.1587537673010;
        Tue, 21 Apr 2020 23:41:13 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r23sm4488120pfr.64.2020.04.21.23.41.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:41:12 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:41:07 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 06/18] mm: memcontrol: prepare uncharging for removal of
 private page type counters
Message-ID: <20200422064106.GF6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-7-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:14PM -0400, Johannes Weiner wrote:
> The uncharge batching code adds up the anon, file, kmem counts to
> determine the total number of pages to uncharge and references to
> drop. But the next patches will remove the anon and file counters.
> 
> Maintain an aggregate nr_pages in the uncharge_gather struct.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
