Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392FB4EB881
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiC3Cyi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 22:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiC3Cyi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 22:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC2717F3F5
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648608773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma0cdZKvD2y8q033msWkRp2PLEzhGQ/8y/lyYzyaHeg=;
        b=Mx0ieUTdU+kloR8uaNZpzoFCKpCyeUTDNFRCywoyz0HjglZ96A7Ji6/f6/EgZqwPhSfWKC
        7bty6q6dNbU7xnnAaWvJGfoeC6zM12a5MJ5pKuCc4YUHvA3Ul6oEk3A8qhoyNQqmHm1mFJ
        bS5euydr777E/LfkH6EsnoRtuohv0MQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-Q5xE2SThPCiJHsdEGKeeRQ-1; Tue, 29 Mar 2022 22:52:52 -0400
X-MC-Unique: Q5xE2SThPCiJHsdEGKeeRQ-1
Received: by mail-lf1-f69.google.com with SMTP id h14-20020a056512220e00b0044a1337e409so5979381lfu.12
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 19:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma0cdZKvD2y8q033msWkRp2PLEzhGQ/8y/lyYzyaHeg=;
        b=ULcxdJCbnv7jGD/8I4v71YhxNp8emai92HvqNIkWLz6/9REPBOArHXBo28hpVPML3a
         UyepCjREx85QGTe6+fbmoZwFLIEbf888MhSYDI8c7qxpC7/ZbpWVzeeEUu5GO3A4TVlQ
         SRPwtVwRBsVgWBzG5D5XicMHX+kTx9fhrtmEUODgvfuMHs0Bu68D0KOYQn8sSnxWVy2q
         0ci+sgPOpIdr/wHxVMubgIAMYYOwNpztEE1ENuhYL0RtNVTvatYdqnbmFt92O9ldQCiF
         V36mxNJQ1b2MBJuKMfQ0crEJqu73Q8vaSonx3gj80drzDtY0PRzVVYC7Q8U3qDkTbBoA
         MSgA==
X-Gm-Message-State: AOAM530YsXrdQA21Di2XQHqRa+eyOGafYlzKgNsSTshlwWLTvLJ5ZNm0
        fWgI9gKCJ6vGPR8ZQ4zbhT0kjgJ653BBxmlUv+pMrCJtXg7oO3UYy5k3Wmdw7uejDGiRur0PMVo
        v+HmApe1mm6g9qdh1cTsECjfd00hQQFMtbA==
X-Received: by 2002:a2e:9c8:0:b0:248:f8:67c5 with SMTP id 191-20020a2e09c8000000b0024800f867c5mr4912819ljj.19.1648608770580;
        Tue, 29 Mar 2022 19:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkIA/whlS3j6eKLVHrldj2gWMf7FSGbkfNTmCl8OCDZ34eNxVwmazKVZychrCmUiRKlM0h/YaN1Vs3UK4+JYA=
X-Received: by 2002:a2e:9c8:0:b0:248:f8:67c5 with SMTP id 191-20020a2e09c8000000b0024800f867c5mr4912804ljj.19.1648608770371;
 Tue, 29 Mar 2022 19:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000921fd405db62096a@google.com>
In-Reply-To: <000000000000921fd405db62096a@google.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 30 Mar 2022 10:52:38 +0800
Message-ID: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
To:     syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 5:23 AM syzbot
<syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
for-5.18/block

It should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a

Thanks,

