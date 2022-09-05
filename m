Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C885AD396
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiIENOm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiIENOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 09:14:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5410DE97
        for <cgroups@vger.kernel.org>; Mon,  5 Sep 2022 06:14:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1D451FEAE;
        Mon,  5 Sep 2022 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662383676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odeJqpDcCxpX8r1tp05w8dWsivXfrVnH9KQIlvGGAiY=;
        b=mH9nstggkl70jXef3R7A+xB5wXtVaBly5uw2TFaShC6zQMLS/K1tV2TfXViaXp7qVa2ajW
        G+ATz4m570suY1xDlEeBUIQOgXxmRujMPHfQ3ez7mec6d/rcmWBrWyLCyvl1JkhDbt9JkX
        hmEmwi4tjQ1y8tf+vDDt5bnRd7NeUqY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F641139C7;
        Mon,  5 Sep 2022 13:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E14pHjz2FWMeGQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 05 Sep 2022 13:14:36 +0000
Date:   Mon, 5 Sep 2022 15:14:35 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <20220905131435.GA1765@blackbody.suse.cz>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxUUISLVLEIRBwEY@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Sun, Sep 04, 2022 at 11:09:53AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Let's track whether a cftype is currently added or not using a new flag
> __CFTYPE_ADDED

IIUC, the flag is equal to (cft->ss || cft->kf_ops), particularly the
information is carried in cfs->kf_ops too.

Is the effect of cgroup_init_cftypes proper setup of cft->kf_ops?
I.e. isn't it simpler to just check that field (without the new flag)?

(No objection to current form, just asking whether I understand the
impact.)

Thanks,
Michal
