Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF206A7381
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCASfc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCASf3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 13:35:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040F4BE84;
        Wed,  1 Mar 2023 10:35:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEBD021AAE;
        Wed,  1 Mar 2023 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677695726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wf0mD7k3wd9pu1O3LZesHDQH1X0cWEqYTsQRgJAz/JI=;
        b=L6vDbXZpy0lNSzxUMms4I0wHVTM6awFbslQl43mrBFRtHAdGVwdgDOXZBmZfbDLIWT0uF/
        ogNoBc6TqAHVS8pw8Cs4WPthRjkE8V2MB0rKjnxTIbMaraLXGeeEAURWjStIXctM8F8BiS
        M3Kcgdt1zp+f5/ONAGx9TSOwAM3K16A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8482413A63;
        Wed,  1 Mar 2023 18:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rmRuHe6a/2MdQwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Mar 2023 18:35:26 +0000
Date:   Wed, 1 Mar 2023 19:35:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup: limit cgroup psi file writes to processes
 with CAP_SYS_RESOURCE
Message-ID: <Y/+a7fczvsVe2lPP@dhcp22.suse.cz>
References: <20230301014651.1370939-1-surenb@google.com>
 <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
 <CAJuCfpERczW1YhEW0fN3p2zrdDj-Ec_pCONH6SQVEwTj0BHYMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpERczW1YhEW0fN3p2zrdDj-Ec_pCONH6SQVEwTj0BHYMw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 01-03-23 10:05:36, Suren Baghdasaryan wrote:
[...]
> Yes but hopefully my argument about keeping this and min period
> patches separate is reasonable?

I am not questioning that. The practical advantage to squash the two
changes is that in case of the CAP_SYS_RESOURCE you do not have to
explicitly think about reverting the min constrain as well. I do not
think reverting one without the other is good.

-- 
Michal Hocko
SUSE Labs
