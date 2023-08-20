Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660BF782031
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 23:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjHTVaE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjHTV3v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 17:29:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4DAE9;
        Sat, 19 Aug 2023 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gr55w12BJ8HanXJKtEGmjMkhrZT3R55wNuvQW7dICuQ=; b=IrDzPDlxB0+dYccoVG43B3F+hs
        1OlUNYHcISxSlyVVSc8T51Mwcg65C6q7VnWkafRYHxD3dFvEEYGtOD9KEAxSoCDJ7Da2puA3fGkV9
        eJ9DywZDzWlFeQpO6QKeCnC4Nhawgm/ffygvpMOLaYAMyt4FSo8DZwi7el7OMOEMWRmJmFIPkyl4/
        VsrXJBWypxSwzvTdjaAoEnPmgcgfnsQ0jxjx4encoHDS/EKYzfUkCGWXxCaKII0nRHQbhAu4t+uFj
        3zFVvICX17teJDcJ0YRGuXgvRB/943ATEPGfLkYE3q0wxfxCv3R3hZvABPRqbfAUqPptEsuPX43Q/
        q1FIV9rQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qXWfc-00BHof-35;
        Sun, 20 Aug 2023 00:51:58 +0000
Message-ID: <26481804-ae24-beb9-9374-8050b4ac070a@infradead.org>
Date:   Sat, 19 Aug 2023 17:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/4] mm: Fix clean_record_shared_mapping_range kernel-doc
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-4-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20230818200630.2719595-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 8/18/23 13:06, Matthew Wilcox (Oracle) wrote:
> Turn the a), b) into an unordered ReST list and remove the unnecessary
> 'Note:' prefix.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  mm/mapping_dirty_helpers.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index a26dd8bcfcdb..2f8829b3541a 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -288,13 +288,14 @@ EXPORT_SYMBOL_GPL(wp_shared_mapping_range);
>   * @end: Pointer to the number of the last set bit in @bitmap.
>   * none set. The value is modified as new bits are set by the function.
>   *
> - * Note: When this function returns there is no guarantee that a CPU has
> + * When this function returns there is no guarantee that a CPU has
>   * not already dirtied new ptes. However it will not clean any ptes not
>   * reported in the bitmap. The guarantees are as follows:
> - * a) All ptes dirty when the function starts executing will end up recorded
> - *    in the bitmap.
> - * b) All ptes dirtied after that will either remain dirty, be recorded in the
> - *    bitmap or both.
> + *
> + * * All ptes dirty when the function starts executing will end up recorded
> + *   in the bitmap.
> + * * All ptes dirtied after that will either remain dirty, be recorded in the
> + *   bitmap or both.
>   *
>   * If a caller needs to make sure all dirty ptes are picked up and none
>   * additional are added, it first needs to write-protect the address-space

-- 
~Randy
