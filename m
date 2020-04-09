Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F371A2D8B
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 04:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDICLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 22:11:23 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39304 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDICLW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 22:11:22 -0400
Received: by mail-qv1-f68.google.com with SMTP id v38so4792894qvf.6;
        Wed, 08 Apr 2020 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PORm90f1pekSo7bdM0jl5Wn3WR0naU3nSTdhyq8uYF0=;
        b=T7Rj9zyj69ZjK6UUEO6kzWCkTN/EwkDBjftpLUmOoy9ZB1aMICdyUvPrhIq0blPOXg
         a4mYkkazrJEhsteIcsHnJPqWFYq+z141WBvuBrxW8zrQqiX/C0Ys7B9XpXXKv9Hvzb/M
         bJxcXhcS62pgMWyykdwMuckw9Bu0QbBtd4wyDLaXCLO3TNufqMnjv2odgNsWl5Vjd9mj
         +OuDDXK11Z87WmD2bgPSFFTQKfbnTjJVF1ZUn0Tjl6Sl9rgvYCR6DrR3NPuOoZukSEMX
         8pjlDSERna/H/T/2EikNzUzxvKbrn2zORX8dJ3+en8mV4cxuYQzhzYEl4rpXU/UTdSW4
         ostQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PORm90f1pekSo7bdM0jl5Wn3WR0naU3nSTdhyq8uYF0=;
        b=ZS9OQMFqWEOpv6YEfvedEpfxry53ZE/IIcBLxNcZH3reiE8BAA5OA2pClkzW3fkBBj
         rNnn6DYNb0TSbqkCJth434bd5P/vw/2cBnaq0Vbw+oLzhUbOe6/qk0D0JjvT1YdaN7Qd
         W149TJGDI1Cxqm+DPmn3i6/CllsFtDfPR6RKL46glN2qHWlK7qY/IxpoHjcig+RoPaCM
         sr2SmOUUyD9CVGopKqZiyckTiaW5LKZGT9ioEcY+T9SapBWSKQlPX7jXt6yOC/DSrVRC
         F7f+8Uaa+6oTV7VmOKku1Fj7VPu3GmzznjYQx41yHPTPaG0ZwGuuxUvFNiv6jhR4C0kW
         T1Fg==
X-Gm-Message-State: AGi0PubUKkmxNOXHvw7BznNHrl1KX7l/m/fpjnMpjPnzJdXJ0941JetQ
        tSUdeF5RKbGeLIwWTCPvntg=
X-Google-Smtp-Source: APiQypJotzBtsOA9saexNnYizl0kD5h0AWOt1lJg0kifNPqcHGFPhU5tyn3VYJ9TDHlIrhHAjMFWlQ==
X-Received: by 2002:a0c:85c6:: with SMTP id o64mr876015qva.11.1586398281764;
        Wed, 08 Apr 2020 19:11:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id c6sm4248088qka.58.2020.04.08.19.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 19:11:21 -0700 (PDT)
Date:   Wed, 8 Apr 2020 22:11:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200409021119.GJ162390@mtj.duckdns.org>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <20200409014406.GA370295@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409014406.GA370295@localhost.localdomain>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 09, 2020 at 09:44:06AM +0800, Ming Lei wrote:
> Almost all __blk_mq_end_request() follow blk_update_request(), so the
> completed bytes can be passed to __blk_mq_end_request(), then we can
> avoid to introduce this field.

But on some drivers blk_update_request() may be called multiple times before
__blk_mq_end_request() is called and what's needed here is the total number of
bytes in the whole request, not just in the final completion.

> Also there is just 20 callers of __blk_mq_end_request(), looks this kind
> of change shouldn't be too big.

This would work iff we get rid of partial completions and if we get rid of
partial completions, we might as well stop exposing blk_update_request() and
__blk_mq_end_request().

Thanks.

-- 
tejun
