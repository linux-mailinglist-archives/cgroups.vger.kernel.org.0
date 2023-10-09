Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C77BD465
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjJIHef (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 03:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJIHef (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 03:34:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2794;
        Mon,  9 Oct 2023 00:34:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE8B11F38C;
        Mon,  9 Oct 2023 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696836871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ux/+/9XoY3oQURe42Bewxjm9Kmqy/ecxPscylyqtj2E=;
        b=Lfy+gS69AXpu3lfZDmrd8R4lwf5xDlm42obXuhcVINuRKO67ywl5EBohdpjiPdRdEyNGBV
        VLk/c+WHLxkMiBbEjgX96kDpRE0KRKm++tCZ7O+nlJMJ7FdicVtzFqRUkPELaayWTdU21Q
        IrhmIEa1KPPrqr7SSD/VXYdfxyOqIGs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9308813905;
        Mon,  9 Oct 2023 07:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZjJLIwetI2W9JAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 09 Oct 2023 07:34:31 +0000
Date:   Mon, 9 Oct 2023 09:34:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Jianlin Lv <iecedge@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        yosryahmed@google.com, willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        peterx@redhat.com, vishal.moola@gmail.com, hughd@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com
Subject: Re: [PATCH] memcg: add interface to force disable swap
Message-ID: <ZSOtBsigRV4RGNXn@dhcp22.suse.cz>
References: <20231007130905.78554-1-jianlv@ebay.com>
 <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com>
 <87il7hjzdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAFA-uR9n-rKw4k26Bhm=P16jOMtAncRsno7o=yYJ1kTxmB_mRw@mail.gmail.com>
 <87edi4jq19.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edi4jq19.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 09-10-23 13:58:10, Huang, Ying wrote:
> Jianlin Lv <iecedge@gmail.com> writes:
> 
> > On Sun, Oct 8, 2023 at 4:26 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Jianlin Lv <iecedge@gmail.com> writes:
> >>
> >> > On Sun, Oct 8, 2023 at 9:17 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Jianlin Lv <iecedge@gmail.com> writes:
> >> >>
> >> >> > From: Jianlin Lv <iecedge@gmail.com>
> >> >> >
> >> >> > Global reclaim will swap even if swappiness is set to 0.
> >> >>
> >> >> Why?  Can you elaborate the situation?
> >> >
> >> > We reproduced the issue of pages being swapped out even when swappiness is
> >> > set to 0 in the production environment through the following test program.
> >> > Not sure whether this program can reproduce the issue in any environment.
> >> >
> >> > From the implementation of the get_scan_count code, it can be seen that,
> >> > based on the current runtime situation, memory reclamation will choose a
> >> > scanning method (SCAN_ANON/SCAN_FILE/SCAN_FRACT) to determine how
> >> > aggressively the anon and file LRU are scanned. However, this introduces
> >> > uncertainty.
> >> >
> >> > For the JVM issue at hand, we expect deterministic SCAN_FILE scan to avoid
> >> > swapping out anon pages.
> >>
> >> Why doesn't memory.swap.max work?
> >
> > The main reason is that deployed nodes  are kept on cgroups v1.

Please note that cgroups v1 is in the maintenance mode with no new
functionality to be added. What is the reason you are sticking with v1?

> Check the code again.  IIUC, for swappiness == 0, anonymous pages will
> only be reclaimed if sc->file_is_tiny is true.

For the memcg reclaim (i.e. not the global one) we try to avoid swapping
even when file_is_tiny IIRC.

> If we don't swap in that
> situation, OOM may be triggerred.  I don't think that it's a good idea
> to do that.  Or I miss something?

Or even worse the system might start trashing heavily over that
remaining tiny page cache.

-- 
Michal Hocko
SUSE Labs
