Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C874A592FCC
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbiHONXq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiHONXj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 09:23:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA701EEF4;
        Mon, 15 Aug 2022 06:23:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83E8D20B30;
        Mon, 15 Aug 2022 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660569812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFv09Z66+Z9RxDrPyMXwvJHVM1uCWbRmOhnW660hzr8=;
        b=OqWPme3xuINwEeKBN52NXE/mRAnqhga05GZ3BOi4GLrd0F7tILAEBTFWeoaS5WpMm6U+b+
        99RNE/4Qgco/1FgCOblmw6w72VMGekSH328mCz2Y/HUt2vT9VlPdp0Ao+3RgrpKlVxMDnY
        gZBftxajDbblyzNmxcKMRxps1F0Fs0Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2917F13A93;
        Mon, 15 Aug 2022 13:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LprDCNRI+mJuRAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 15 Aug 2022 13:23:32 +0000
Date:   Mon, 15 Aug 2022 15:23:30 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <20220815132330.GA24237@blackbody.suse.cz>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvYoFNDMdg6mdFbU@blackbook>
 <5ce118b3-bf3b-d9a4-004c-a5a355984b0f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce118b3-bf3b-d9a4-004c-a5a355984b0f@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 12, 2022 at 08:36:17PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> Could you help take a look if there is anything to improve?

Thanks, just a little nit.

> +       The reason this control attribute exists is that PSI accounts stalls for
> +       each cgroup separately and aggregates it at each level of the hierarchy.
> +       This may cause non-negligible overhead for some workloads when under
> +       deep level of the hierarchy, in which case this control attribute can
> +       be used to disable PSI accounting in the cgroups.

s/in the cgroups/in the non-leaf cgroups/
or
s/in the cgroups/in the uninteresting cgroups/

(I'm concerned that it may result in lots of disabling if you want the
performance. I'll expand on it in 2nd subthread.)

Michal
