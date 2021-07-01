Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347DB3B8E10
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhGAHNj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhGAHNd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:13:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74069C0617A8
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=vDKJb0soHg96ca/OPz+A7fZLgE
        6i2oBe6Kh+/yew0wOCBwMZ9YoCHqI0T2cNL9qgiAB7kQdNj3mVsqeqLJ3uNSN3eDEsrncbl7DD3lN
        wZgL2xZMkJGH2Aljwdxm6RqhYZspZyPjk0LYEA9KsJFM5hbxZD/OK+22KVzU6Qfbshhs7i17l6sHc
        Fb/HAT6OWkn2/2dQ0hS0kL77MpmzpCpK6ztmOicc4JTZ8iM7Z5xRFph56ajpclXsmEWbEisk7lYeh
        6Im8xxW2gGh3PttTUBPIFqNYafCBpT75khb0nLX5KfWFCc3fn3aD9Dt0WFNMGJH8Ub7IaRzy+fvuj
        kmNLcvgA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqpf-006HRA-AN; Thu, 01 Jul 2021 07:10:05 +0000
Date:   Thu, 1 Jul 2021 08:09:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 05/18] mm/memcg: Convert memcg_check_events to take a
 node ID
Message-ID: <YN1qQwZR22WySwNw@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
