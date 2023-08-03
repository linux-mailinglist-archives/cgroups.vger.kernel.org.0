Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42BF76ED45
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHCO4A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjHCOz6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 10:55:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBA173F;
        Thu,  3 Aug 2023 07:55:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C0E21F747;
        Thu,  3 Aug 2023 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691074556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/VNlnAgBc91S2tYQvLwrXhvlLqKeVtz0vo49rvSQNPE=;
        b=kVP0di1gzsJsEBbQQkq4/uiFNVNskhJjfzgyi/9R6Qhac7n1+AnbpJ3GFGHXK1e+0/sDW6
        sq63HRQ8VLd7ptKuupjYjswPoJqTloEdleyab3q5EYZ4DzgBIi9l/Py/OhKsDxNCtMEd3n
        8pBrxdzb8ugos/N86bbFPaoIGR7Bv4s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E03134B0;
        Thu,  3 Aug 2023 14:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id orjIBvy/y2SwHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Aug 2023 14:55:56 +0000
Date:   Thu, 3 Aug 2023 16:55:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <ZMu/+ysmksCZqcem@dhcp22.suse.cz>
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com>
 <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
 <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
 <ZMoIYLwITUZzXp4C@dhcp22.suse.cz>
 <CAJD7tkY4hTTCfqSGa_XexbH=WSTJ4WXWeMXSU+6KW8qfr7agfQ@mail.gmail.com>
 <CAJD7tkb17x=qwoO37uxyYXLEUVp15BQKR+Xfh7Sg9Hx-wTQ_=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb17x=qwoO37uxyYXLEUVp15BQKR+Xfh7Sg9Hx-wTQ_=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 02-08-23 15:02:55, Yosry Ahmed wrote:
[...]
> Let me know if the testing is satisfactory for you. I can send an
> updated commit log accordingly with a summary of this conversation.

Yes this should be sufficient as it exercises all the CPUs so the
overhead in flushing should be visible if this was a real deal. I would
have gone with kernel build test as that has a broader code coverage but
this artificial test should give some red flags as well. So good enough.
Amending the changelog with this would be helpful as well so that future
us and others will know what kind of testing has been done.

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> > > --
> > > Michal Hocko
> > > SUSE Labs

> #!/bin/bash
> 
> NR_CPUS=$(getconf _NPROCESSORS_ONLN)
> NR_CGROUPS=$(( NR_CPUS * 2 ))
> TEST_MB=50
> TOTAL_MB=$((TEST_MB * NR_CGROUPS))
> TMPFS=$(mktemp -d)
> ROOT="/sys/fs/cgroup/"
> ZRAM_DEV="/mnt/devtmpfs/zram0"
> 
> cleanup() {
>   umount $TMPFS
>   rm -rf $TMPFS
>   for i in $(seq $NR_CGROUPS); do
>     cgroup="$ROOT/cg$i"
>     rmdir $cgroup
>   done
>   swapoff $ZRAM_DEV
>   echo 1 > "/sys/block/zram0/reset"
> }
> trap cleanup INT QUIT EXIT
> 
> # Setup zram
> echo $((TOTAL_MB << 20)) > "/sys/block/zram0/disksize"
> mkswap $ZRAM_DEV
> swapon $ZRAM_DEV
> echo "Setup zram done"
> 
> # Create cgroups, set limits
> echo "+memory" > "$ROOT/cgroup.subtree_control"
> for i in $(seq $NR_CGROUPS); do
>   cgroup="$ROOT/cg$i"
>   mkdir $cgroup
>   echo $(( (TEST_MB << 20) / 4)) > "$cgroup/memory.max"
> done
> echo "Setup cgroups done"
> 
> # Start workers to allocate tmpfs memory
> mount -t tmpfs none $TMPFS
> for i in $(seq $NR_CGROUPS); do
>   cgroup="$ROOT/cg$i"
>   f="$TMPFS/tmp$i"
>   (echo 0 > "$cgroup/cgroup.procs" &&
>     dd if=/dev/zero of=$f bs=1M count=$TEST_MB status=none &&
>     cat $f > /dev/null)&
> done
> 
> # Wait for workers
> wait


-- 
Michal Hocko
SUSE Labs
