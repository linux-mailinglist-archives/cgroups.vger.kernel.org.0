Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992AA5422FE
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiFHAnf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jun 2022 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447492AbiFGXG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jun 2022 19:06:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12CB30B6C7;
        Tue,  7 Jun 2022 13:37:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEA211F92D;
        Tue,  7 Jun 2022 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654633808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S662GbsRJEF6AHR2EvNBu53yF5E9DczgAYsnFafgTMM=;
        b=y+HqAzNlLnb/PDQh+aDQgxfaXgDgFlpkBvWu4r6aN2XYXDxi3irQSc60/Y6dgoXm04rQFz
        sMIP6F+daG66o5WdjUGi8iXe0PX2bcB6wbrwQ2R2UcXjAnNoLODEBL5wUSyeLtPeK9WQ/b
        3OsfhBPVSLIhjCFDsHZphJ5Ha5hkf30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654633808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S662GbsRJEF6AHR2EvNBu53yF5E9DczgAYsnFafgTMM=;
        b=TcXr8fp5++MDzVzG7XmA0OcwUhraygWKTXnVJ0DJDg28V6CTQfFJS6yQY+qyTnTVBROKFH
        KpQDy3na/34Y1jCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D1392C141;
        Tue,  7 Jun 2022 20:30:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 251ABA0633; Tue,  7 Jun 2022 22:30:08 +0200 (CEST)
Date:   Tue, 7 Jun 2022 22:30:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Message-ID: <20220607203008.nk4cpcny5sfl4am7@quack3.lan>
References: <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <20220523085902.wmxoebyq3crerecr@quack3.lan>
 <25f6703e-9e10-75d9-a893-6df1e6b75254@kernel.dk>
 <20220523152516.7sr247i3bzwhr44w@quack3.lan>
 <21cd1c49-838a-7f03-ab13-9a4f2ac65979@huawei.com>
 <20220607095430.kac5jgzm2gvd7x3c@quack3.lan>
 <9a51c7b1-ba6c-0a56-85cf-5e602b9c6ec2@huawei.com>
 <75ebf18b-0e21-3906-7862-6ca80b2f181d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75ebf18b-0e21-3906-7862-6ca80b2f181d@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 07-06-22 21:06:55, Yu Kuai wrote:
> 在 2022/06/07 19:51, Yu Kuai 写道:
> > 在 2022/06/07 17:54, Jan Kara 写道:
> > > On Tue 07-06-22 11:10:27, Yu Kuai wrote:
> > > > 在 2022/05/23 23:25, Jan Kara 写道:
> > > > > Hum, for me all emails from Huawei I've received even today
> > > > > fail the DKIM
> > > > > check. After some more digging there is interesting
> > > > > inconsistency in DMARC
> > > > > configuration for huawei.com domain. There is DMARC record
> > > > > for huawei.com
> > > > > like:
> > > > > 
> > > > > huawei.com.        600    IN    TXT
> > > > > "v=DMARC1;p=none;rua=mailto:dmarc@edm.huawei.com"
> > > > > 
> > > > > which means no DKIM is required but _dmarc.huawei.com has:
> > > > > 
> > > > > _dmarc.huawei.com.    600    IN    TXT    "v=DMARC1;p=quarantine;ruf=mailto:dmarc@huawei.com;rua=mailto:dmarc@huawei.com"
> > > > > 
> > > > > 
> > > > > which says that DKIM is required. I guess this inconsistency may be the
> > > > > reason why there are problems with DKIM validation for senders from
> > > > > huawei.com. Yu Kuai, can you perhaps take this to your IT
> > > > > support to fix
> > > > > this? Either make sure huawei.com emails get properly signed
> > > > > with DKIM or
> > > > > remove the 'quarantine' record from _dmarc.huawei.com. Thanks!
> > > > > 
> > > > >                                 Honza
> > > > > 
> > > > Hi, Jan and Jens
> > > > 
> > > > I just got response from our IT support:
> > > > 
> > > > 'fo' is not set in our dmarc configuration(default is 0), which means
> > > > SPF and DKIM verify both failed so that emails will end up in spam.
> > > > 
> > > > It right that DKIM verify is failed because there is no signed key,
> > > > however, our IT support are curious how SPF verify faild.
> > > > 
> > > > Can you guys please take a look at ip address of sender? So our IT
> > > > support can take a look if they miss it from SPF records.
> > > 
> > > So SPF is what makes me receive direct emails from you. For example
> > > on this
> > > email I can see:
> > > 
> > > Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
> > >          [185.176.79.56])
> > >          (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256
> > > (128/128
> > >          bits))
> > >          (No client certificate requested)
> > >          by smtp-in2.suse.de (Postfix) with ESMTPS id 4LHFjN2L0dzZfj
> > >          for <jack@suse.cz>; Tue,  7 Jun 2022 03:10:32 +0000 (UTC)
> > > ...
> > > Authentication-Results: smtp-in2.suse.de;
> > >          dkim=none;
> > >          dmarc=pass (policy=quarantine) header.from=huawei.com;
> > >          spf=pass (smtp-in2.suse.de: domain of yukuai3@huawei.com
> > > designates
> > >          185.176.79.56 as permitted sender)
> > > smtp.mailfrom=yukuai3@huawei.com
> > > 
> > > So indeed frasgout.his.huawei.com is correct outgoing server which makes
> > > smtp-in2.suse.de believe the email despite missing DKIM signature.
> > > But the
> > > problem starts when you send email to a mailing list. Let me take for
> > > example your email from June 2 with Message-ID
> > > <20220602082129.2805890-1-yukuai3@huawei.com>, subject "[PATCH -next]
> > > mm/filemap: fix that first page is not mark accessed in filemap_read()".
> > > There the mailing list server forwards the email so we have:
> > > 
> > > Received: from smtp-in2.suse.de ([192.168.254.78])
> > >          (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256
> > > bits))
> > >          by dovecot-director2.suse.de with LMTPS
> > >          id 8MC5NfVvmGIPLwAApTUePA
> > >          (envelope-from <linux-fsdevel-owner@vger.kernel.org>)
> > >          for <jack@imap.suse.de>; Thu, 02 Jun 2022 08:08:21 +0000
> > > Received: from out1.vger.email (out1.vger.email
> > > [IPv6:2620:137:e000::1:20])
> > >          by smtp-in2.suse.de (Postfix) with ESMTP id 4LDJYK5bf0zZg5
> > >          for <jack@suse.cz>; Thu,  2 Jun 2022 08:08:21 +0000 (UTC)
> > > Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
> > >          id S232063AbiFBIIM (ORCPT <rfc822;jack@suse.cz>);
> > >          Thu, 2 Jun 2022 04:08:12 -0400
> > > Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
> > >          lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by
> > >          vger.kernel.org
> > >          with ESMTP id S232062AbiFBIIL (ORCPT
> > >          <rfc822;linux-fsdevel@vger.kernel.org>);
> > >          Thu, 2 Jun 2022 04:08:11 -0400
> > > Received: from szxga02-in.huawei.com (szxga02-in.huawei.com
> > > [45.249.212.188])
> > >          by lindbergh.monkeyblade.net (Postfix) with ESMTPS id
> > >          75DDB25FE;
> > >          Thu,  2 Jun 2022 01:08:08 -0700 (PDT)
> > > 
> > > and thus smtp-in2.suse.de complains:
> > > 
> > > Authentication-Results: smtp-in2.suse.de;
> > >          dkim=none;
> > >          dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM"
> > >          header.from=huawei.com (policy=quarantine);
> > >          spf=pass (smtp-in2.suse.de: domain of
> > >          linux-fsdevel-owner@vger.kernel.org designates
> > > 2620:137:e000::1:20 as
> > >          permitted sender)
> > > smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
> > > 
> > > Because now we've got email with "From" header from huawei.com
> > > domain from
> > > a vger mail server which was forwarding it. So SPF has no chance to match
> > > (in fact SPF did pass for the Return-Path header which points to
> > > vger.kernel.org but DMARC defines that if "From" and "Return-Path" do not
> > > match, additional validation is needed - this is the "SPF not aligned
> > > (relaxed)" message above). And missing DKIM (the additional validation
> > > method) sends the email to spam.
> > 
> > Thanks a lot for your analysis, afaics, in order to fix the
> > problem, either your mail server change the configuration to set
> > alignment mode to "relaxed" instead of "strict", or our mail server
> > add correct DKIM signature for emails.
> > 
> > I'll contact with our IT support and try to add DKIM signature.
> > 
> > Thanks,
> > Kuai
> 
> Hi, Jan
> 
> Our IT support is worried that add DKIM signature will degrade
> performance, may I ask that how is your mail server configuation? policy
> is quarantine or none, and dkim signature is supportted or not.

The DMARC policy (relaxed / quarantine) is not configured on the side of
the receiving mail server but on huawei.com side. As I wrote above it is
this DMARC record in DNS of huawei.com domain that makes receiving mail
servers refuse the email without DKIM signature (if SPF does not match):

_dmarc.huawei.com.    600    IN    TXT    "v=DMARC1;p=quarantine;ruf=mailto:dmarc@huawei.com;rua=mailto:dmarc@huawei.com"

So if your IT admins do not want to introduce DKIM signatures on outgoing
email, they should set policy to 'p=none' in the DMARC DNS record to tell
that fact to receiving mail servers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
