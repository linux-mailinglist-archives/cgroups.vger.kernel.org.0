Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C914EB89E
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiC3DDt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 23:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiC3DDs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 23:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235BC1753BE
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648609323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xxzvoUYwD8SSYfs6qQXKCiAwI4oUDxgTEMP9uTO4mCk=;
        b=KFyV9WEfOFVEh2fyBt/2wDS2gnGK3LWjZYYCUu10rQ6kPP2iBMQVjnlQDyw1PqYK0nigwZ
        7XrumxjBl6LxVhvm1wm0z3hdKK5ZHD39XKx9RYgTbafwMDoaVSrZWzDQgIKq6Y+Dq8ZamS
        uMG5Aou5sQN5Ss9K6DZvrpA/TmN1v3A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-OWISo9TON5mPeQ0u3-hOeQ-1; Tue, 29 Mar 2022 23:01:59 -0400
X-MC-Unique: OWISo9TON5mPeQ0u3-hOeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6541029DD991;
        Wed, 30 Mar 2022 03:01:59 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69D652166B3F;
        Wed, 30 Mar 2022 03:01:45 +0000 (UTC)
Date:   Wed, 30 Mar 2022 11:01:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
Message-ID: <YkPIFKn0osBGOgma@T590>
References: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
 <0000000000009518f205db66a47a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009518f205db66a47a@google.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 29, 2022 at 07:52:57PM -0700, syzbot wrote:
> > On Wed, Mar 30, 2022 at 5:23 AM syzbot
> > <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> This crash does not have a reproducer. I cannot test it.

This one is triggered in case of memory allocation failure, especially blkg_free()
is called from blkg_alloc() directly. That is why it is hard to reproduce, and it
is one old issue.


Thanks,
Ming

