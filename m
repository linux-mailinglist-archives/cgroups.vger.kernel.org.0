Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D440C40F8A9
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhIQNER (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbhIQNEI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 09:04:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDE4C061574;
        Fri, 17 Sep 2021 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/rZz1r8xXREUazeDrzdFdL0EcUy/UUby58bFIJOi0A0=; b=r/AfEsfrDvBads4CkLPNVdmVgN
        YmZ7tAS6VQTIS26ucECW/cgtPnh1nzChv3KEIXdE4TPaIIJkglxPHAXXOXHs+puJvGTuXid9ZfcqX
        IXtUT5yFJJnKINP4cnaC/e7m/lDU9ySoCq25uftbN+M/F2PziqZzx412M7a8vgmNwUubwGZI3oJr2
        jlEm5scesU9I0F4UKhBwC3tbpWrQ/wSKiGbezE81+1/cZMEABogIEB5J+LF74PPpLGTQyOzc1/Orm
        uUKtXo4MzGcJr8OB1ESnSort7alvZpcKPjhr3EGKFxnSk89hIoll2Dvqo7zjItfgJ7TiBeSaqTbVf
        RQj4s+Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRDUi-000GFn-Hj; Fri, 17 Sep 2021 13:01:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AB8A30031A;
        Fri, 17 Sep 2021 15:01:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D4E6285DCA77; Fri, 17 Sep 2021 15:01:31 +0200 (CEST)
Date:   Fri, 17 Sep 2021 15:01:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Memcached with cfs quota 400% performance boost after bind to 4
 cpus
Message-ID: <YUSRqyfE2DjJhtHc@hirez.programming.kicks-ass.net>
References: <9f907d99-1cdb-37db-49ae-8e31c7ea8fe7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f907d99-1cdb-37db-49ae-8e31c7ea8fe7@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 17, 2021 at 08:35:36PM +0800, Wang Jianchao wrote:
> Hi list
> 
> I have a test environment with following,

(forgets to specify the actual hardware...)
