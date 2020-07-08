Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F6218AB2
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2020 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgGHPEY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jul 2020 11:04:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729206AbgGHPEY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jul 2020 11:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594220663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCfFQ9unhV8AALYAbnlDEYp86FEPgYE4PEBMEl3tJ+k=;
        b=CG4COg6xclwjEypPnhQtXV6DUNMAczbN/JgdbKn8fC7f6HCvgw8b8O0IOIKZV/+RNDcggb
        sRhQtnvWezBfEZYeZeljLHpPTjVJhcDGhfUNHXWsJWdSCZFdeq7kEUSuEIFf1anZ97CwKR
        m43qinSj3RxIaW8/PSWCZ50I8nUig0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-_cOtDcHDMqSgQS042k_P3g-1; Wed, 08 Jul 2020 11:04:20 -0400
X-MC-Unique: _cOtDcHDMqSgQS042k_P3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FA510506EE;
        Wed,  8 Jul 2020 15:04:18 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC18910013D7;
        Wed,  8 Jul 2020 15:04:14 +0000 (UTC)
Date:   Wed, 8 Jul 2020 10:02:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 01/14] dm: use bio_uninit instead of bio_disassociate_blkg
Message-ID: <20200708140254.GA7539@redhat.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627073159.2447325-2-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 27 2020 at  3:31am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> bio_uninit is the proper API to clean up a BIO that has been allocated
> on stack or inside a structure that doesn't come from the BIO allocator.
> Switch dm to use that instead of bio_disassociate_blkg, which really is
> an implementation detail.  Note that the bio_uninit calls are also moved
> to the two callers of __send_empty_flush, so that they better pair with
> the bio_init calls used to initialize them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I've picked this up as a fix for 5.8

Thanks,
Mike

