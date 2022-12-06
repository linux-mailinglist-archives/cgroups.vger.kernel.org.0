Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA639644152
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiLFKdT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 05:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiLFKdQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 05:33:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE0DFF6
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 02:33:14 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83E571FE2B;
        Tue,  6 Dec 2022 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670322793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sXtB0LJ1gZ5Q2aHoxbN5D+rA1BRGWLH2LRyfAy0cNtA=;
        b=dMNGtYEU6bdKskTmQkpt4FcDRN92UcqQjVVtK9/Njg6YZcuhQ+6Hth69Qy2QWb6OjdEWXT
        r9M9rpzPKXzw3R5xaI5oSFSnd2bJKb/MkktHhJOec2h9PlWH/SejxdQyOXcdWRB6HLWHWa
        hVn+9lcsEhdTy/Y0D2XAsxyz9mYV+f0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 624AC132F3;
        Tue,  6 Dec 2022 10:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5MKmFWkaj2OnLgAAGKfGzw
        (envelope-from <mhocko@suse.com>); Tue, 06 Dec 2022 10:33:13 +0000
Date:   Tue, 6 Dec 2022 11:33:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     lirongqing@baidu.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm: memcontrol: speedup memory cgroup resize
Message-ID: <Y48aaCkgonOlMwNu@dhcp22.suse.cz>
References: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
 <CALvZod7_1oq1D73EKJHG1zQpeUp+QTPHmMRsL3Ka0f6XUfO4Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7_1oq1D73EKJHG1zQpeUp+QTPHmMRsL3Ka0f6XUfO4Eg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 05-12-22 08:32:41, Shakeel Butt wrote:
> On Mon, Dec 5, 2022 at 3:49 AM <lirongqing@baidu.com> wrote:
> >
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > when resize memory cgroup, avoid to free memory cgroup page
> > one by one, and try to free needed number pages once
> >
> 
> It's not really one by one but SWAP_CLUSTER_MAX. Also can you share
> some experiment results on how much this patch is improving setting
> limits?

Besides a clear performance gain you should also think about a potential
over reclaim when the limit is reduced by a lot (there might be parallel
reclaimers competing with the limit resize).

-- 
Michal Hocko
SUSE Labs
