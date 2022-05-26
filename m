Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84A534CCE
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiEZJ4j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiEZJ4i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 05:56:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7BC9676;
        Thu, 26 May 2022 02:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C63901F91C;
        Thu, 26 May 2022 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653558995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFhmgixX5LOgkqqC8+umKFYLrjndJW5kicXnZWzhHcM=;
        b=IFtKrgBpUSxaIqVCvIEJxuP0+8BajYar9PUK+it7szWAOhxuqgh3gsI50vxQ5v2+PAk+v5
        HmhTw77kSpoGw0/3EJ8WyMbDUAVjADlDKKvwZcwDnjw6FA5moc+3dGsd+gFfKPR7xHm1RT
        FKNfMRfPE3vE2jk8xlz9H4AnRMv+oTs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 968381351F;
        Thu, 26 May 2022 09:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gi+FI9NOj2IBHwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 26 May 2022 09:56:35 +0000
Date:   Thu, 26 May 2022 11:56:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <Yo7KfEOz92kS2z5Y@blackbook>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525161455.GA16134@blackbody.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 06:14:55PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> But the above is not correct. I've looked at the stack trace [1] and the
> offending percpu_ref_put_many is called from an RCU callback
> percpu_ref_switch_to_atomic_rcu(), so I can't actually see why it drops
> to zero there...

The link [1] should have been [1].
After some more thought, the following is possible sequencing of
involved functions.

// ref=A: initial state
kill_css()
  css_get // ref+=F == A+F: fuse
  percpu_ref_kill_and_confirm
    __percpu_ref_switch_to_atomic
      percpu_ref_get
        // ref += 1 == A+F+1: atomic mode, self-protection
    percpu_ref_put
      // ref -= 1 == A+F: kill the base reference
  [via rcu]
  percpu_ref_switch_to_atomic_rcu
    percpu_ref_call_confirm_rcu
      css_killed_ref_fn == refcnt.confirm_switch
        queue_work(css->destroy_work)        (1)
                                                     [via css->destroy_work]
                                                     css_killed_work_fn == wq.func
                                                       offline_css() // needs fuse
                                                       css_put // ref -= F == A: de-fuse
      percpu_ref_put
        // ref -= 1 == A-1: remove self-protection
        css_release                                   // A <= 1 -> 2nd queue_work explodes!
          queue_work(css->destroy_work)      (2)
          [via css->destroy_work]
          css_release_work_fn == wq.func

Another CPU would have to dispatch and run the css_killed_work_fn
callback in parallel to percpu_ref_switch_to_atomic_rcu. It's a more
correct explanation, however, its likelihood does seem very low. Perhaps
some debug prints of percpu_ref_data.data in percpu_ref_call_confirm_rcu
could shed more light onto this [2].

HTH,
Michal

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=162b5781f00000
[2] I tried notifying syzbot about [3] moments ago.
[3] https://github.com/Werkov/linux/tree/cgroup-ml/css-lifecycle-syzbot

