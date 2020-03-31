Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560A6198E3C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 10:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCaIZG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 04:25:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaIZG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 04:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uHShfLyk+r2NtFiic0iTbAAoXgVtjC6D8jlMuvt3O8Y=; b=n5ImjXWjPQw04c5uquw6cwixCv
        e578jSqqpyF1jjdfvtctP4mO/a2CkqhQt617UeqcG7Ay5zz1VUbguxYUT4llyz+IPv+tjjh96qvHc
        0MH0wHtTkTJzBE8gaXP/KWsnZQVIKJJeCBxhgBAiZZqKYqelGWUnVX8hEZ92zxLhxjUBaynD1v2tD
        pmqARRpdJOUaIWWZp3UygBsNnMB8s5/qz9kchbFuncuN6HUolUeX/tXdGO9Q8aqlgJNNHDDLd7Svp
        IgnxLJzB3IDZR998Iik9Bvhg8SJ0QMNEkVSXlnqbcLX78f76825WKxw8lW0i7k0w4ByB79f7Z5U+x
        cYLji1bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJCCn-0004wb-I0; Tue, 31 Mar 2020 08:25:05 +0000
Date:   Tue, 31 Mar 2020 01:25:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] bio: track timestamp of submitting bio the
 disk driver
Message-ID: <20200331082505.GA14655@infradead.org>
References: <20200327062859.GA12588@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327062859.GA12588@192.168.3.9>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 27, 2020 at 02:28:59PM +0800, Weiping Zhang wrote:
> Change-Id: Ibb9caf20616f83e111113ab5c824c05930c0e523
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

This needs a commit description and loose the weird change id.

I also think oyu need to fins a way to not bloat the bio even more,
cgroup is a really bad offender for bio size.
