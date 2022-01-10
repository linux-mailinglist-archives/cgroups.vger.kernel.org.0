Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E751E4896BF
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 11:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiAJKvt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 05:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244313AbiAJKvl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 05:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641811901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uep8m/hs5XUyZjO6T2O4qnfO84NUY7Xj8s7kTpYwtJo=;
        b=KhL+bAjpyDhIqqHNGPDwo8y1KSCBd5bKlgA4Z985oc4t8adVq2iUSxKxvXilyVWZuXAmN2
        QDgRlqidAgVsRYKMtk8wwuw5qIjqDiCIC/oNB4XDJN72ZCq0hmkAU2OW908drY7FVUmnj+
        qONFvYV0b7shHHCAd4OopMlQiL18NsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-aM6BJwXvNJ-5aNcEJ64cIQ-1; Mon, 10 Jan 2022 05:51:36 -0500
X-MC-Unique: aM6BJwXvNJ-5aNcEJ64cIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B6783DD20;
        Mon, 10 Jan 2022 10:51:34 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 340EF4E2A2;
        Mon, 10 Jan 2022 10:51:30 +0000 (UTC)
Date:   Mon, 10 Jan 2022 18:51:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split
Message-ID: <YdwPrsdhwX39IlDG@T590>
References: <1641803363-27550-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641803363-27550-1-git-send-email-brookxu.cn@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chunguang,

On Mon, Jan 10, 2022 at 04:29:23PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> After commit 900e08075202("block: move queue enter logic into
> blk_mq_submit_bio()"), submit_bio_checks() moved to __submit_bio_fops()
> and blk_mq_submit_bio(). The IOs go through blk_mq_submit_bio()
> may be splited before entering blk-throtl, so we need to check
> whether the BIO is throttled, and only update the io_split_cnt
> for the THROTTLED bio to avoid double charge.

Today Jens has merged the patch[1] of "block: don't protect
submit_bio_checks by q_usage_counter", so the behavior is switched
back to previous behavior: running bio check before calling
blk_mq_submit_bio() or ->submit_bio().

Then looks your patch isn't needn't any more.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.17/block&id=9d497e2941c30a060ba62d5485b3bc9d91ffb09e


Thanks,
Ming

