Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF868C76D
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 21:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFURg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 15:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFURf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 15:17:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7232C663;
        Mon,  6 Feb 2023 12:17:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso8878705pjb.3;
        Mon, 06 Feb 2023 12:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzNNQ1ME8UkUfRnNPhvhA1TlYJj5U9rDmc29+BCCEJo=;
        b=Ymr6rMkxUQI0TQbxkvW96Vlu8S7lxnyBnVAkQ3I1A5eZkuKKgVeMvNVHRPN0O/alpS
         LsKhELpnejK7pB3EnCJAaqimJEN2rYEr9s9aRaw+pSv43R5duOkhCUAozj+yXrh8A7qN
         mCvhxqvxaOtzGFL9DAU2sUPmk875fnMYPVpUP8Iffe3lAVdSRRDJnbZSAyMwsvM6JKFu
         k0mA/oFXmMnqweF9ulCFhXnz26DTw2SQbALC/TCAgpBs8mVM4+eeWdKznhHBolirtlfo
         ZptBNTpC1J56nyxdh+k6Qdx9ofk/rqC2ePrCQX6I/G0b0pVoLPGdF8MSCZgOYcBRFl1W
         4M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzNNQ1ME8UkUfRnNPhvhA1TlYJj5U9rDmc29+BCCEJo=;
        b=ccONaFF9Ek6uNMfVnMi66vy7BYqq6ckwxzPGxfuwSTlVFKjHVeXA1qnX4SAftHXWD9
         yGKSmu+Qgw01FIGiZwpaNDfSAq6FsZFg4QXFxZsl/KZEW7te5RjE3DcihuuQa6UgiE4r
         AU++//7UA9qzo0mgDzVYGxdAA8NjT/N1kcJdzQKogKUe8i9rbzWsNaQ6XW722cv8oyqZ
         czCQWi0y5uLYfOMIDhfW+8PHL3GNrvWPpErYbvQ/C6R05GiX3uY9pzuA1QmZG2JiLcM6
         N4uu4s+QIBwr61rkaeJ2KMp4rz15UAPjqM3yCJuwB8IJPcZEEggHl3S5LarwsU4UPeii
         8zig==
X-Gm-Message-State: AO0yUKV+g0SMO6vf3ZZ38AajdlG6dArPIX3hHrzuJFhpkEsl+Bw7I35Q
        rmfQfuFUoo+OCJRFp58WgJI=
X-Google-Smtp-Source: AK7set8rNsBZZNKmtGlKnohJLJDpie6FjDC79vp9srJJR5eV4fVnLnq9lsC2tcuqsQYttlUjzEbrhQ==
X-Received: by 2002:a17:90b:4f83:b0:22b:ae7e:9699 with SMTP id qe3-20020a17090b4f8300b0022bae7e9699mr1038285pjb.12.1675714628308;
        Mon, 06 Feb 2023 12:17:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z19-20020a17090ad79300b00230da56ddecsm625624pju.27.2023.02.06.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:17:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 10:17:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <Y+FgQXvnzSF1OrmO@slm.duckdns.org>
References: <20230203164040.213437-1-longman@redhat.com>
 <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
 <f356b916-1c10-1565-73fb-34027c6c510a@redhat.com>
 <20230206110540.GA11024@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206110540.GA11024@willie-the-truck>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 06, 2023 at 11:05:41AM +0000, Will Deacon wrote:
> > If we want to get it into the next merge windows, there isn't much time left
> > for linux-next testing. So a lower risk solution is better from that
> > perspective too.
> 
> This needs to land for 6.2 to fix the regression. The next merge window is
> too late. That's why I cooked the reverts [1] as an alternative.

Yeah, I think Waiman meant before the coming merge window. We have at least
one more week so let's try the two patches and see how that goes. We can
always revert if it doesn't work out.

Thanks.

-- 
tejun
