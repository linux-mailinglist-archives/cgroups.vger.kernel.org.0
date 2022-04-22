Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C850AEF5
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 06:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355549AbiDVE0R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 00:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352660AbiDVE0Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 00:26:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB34EDC3;
        Thu, 21 Apr 2022 21:23:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80F1368B05; Fri, 22 Apr 2022 06:23:19 +0200 (CEST)
Date:   Fri, 22 Apr 2022 06:23:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <20220422042318.GA9977@lst.de>
References: <20220420042723.1010598-1-hch@lst.de> <YmHQS1pyIglK+gfS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmHQS1pyIglK+gfS@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:43AM -1000, Tejun Heo wrote:
> The patches look all good to me and I'm not against making things more
> private but can you elaborate on the rationale a bit more? By and large, we
> have never been shy about putting things in the headers if there's *any*
> (perceived) gain to be made from doing so, or even just as a way to pick the
> locations for different things - type defs go on header and so on. Most of
> the inlines and [un]likely's that we have are rather silly with modern
> compilers with global optimizations, so it does make sense to get tidier,
> but if that's the rationale, mentioning that in the commit message, even
> briefly, would be great - ie. it should explain the benefits of adding these
> few accessors to keep the definition private.

Mostly to help me understand the code :)  between all the moving to
and from the css struture it is a bit of a mess, and limiting the scope
that deals with the structures greatly helps with that.
