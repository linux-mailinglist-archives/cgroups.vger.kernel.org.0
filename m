Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7E57A0EA
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiGSOMu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiGSOMd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 10:12:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F1CE3C;
        Tue, 19 Jul 2022 06:35:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94DEA347EB;
        Tue, 19 Jul 2022 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658237713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQkGZ2bUCaXoPh/D/Jj4IPkCDd93zpdb0jFOJ4x+L1k=;
        b=RXpYSGlmRcef3l7YiwRFdAApPwXNCGsn0BDGq8RMYOlXFurF0+ck6ho6rGcVbsWtc/fUP6
        De4sOP94LDSs7rGW7/DXiKXGZ3iMCVaCS8xrKMTqCvGXTFpvP8npNoI8fDTvetmmD0jubo
        mc2b6WY+Bg2Qby9yeLCG9cnhEe+PPKo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5975513A72;
        Tue, 19 Jul 2022 13:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I8ALFRGz1mLrXQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 19 Jul 2022 13:35:13 +0000
Date:   Tue, 19 Jul 2022 15:35:12 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Shakeel Butt <shakeelb@google.com>, wsd_upstream@mediatek.com,
        lixiong.liu@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com
Subject: Re: [Bug] race condition at rebind_subsystems()
Message-ID: <20220719133512.GD897@blackbody.suse.cz>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
 <20220715115938.GA8646@blackbody.suse.cz>
 <YtGaP+e35DZYSQf0@slm.duckdns.org>
 <d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 18, 2022 at 03:44:21PM +0800, Jing-Ting Wu <jing-ting.wu@mediatek.com> wrote:
> Accroding your description, is the following patch corrent?

Yes, this is what I meant (i.e. grace period before invalidating the
removed rstat_css_node).

> If the patch is correct, we will add this patch to our stability test.
> And we will continue to observe whether the problem is solved.

It'd be great to have such confirmation.

Thanks,
Michal
